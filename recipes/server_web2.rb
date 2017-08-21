# frozen_string_literal: true
#
# Cookbook Name:: icinga2
# Recipe:: server_web2
#
# Copyright 2014, Virender Khatri
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

cli_package_version = node['icinga2']['web2']['version']['icingacli'] + node['icinga2']['icinga2_version_suffix']
web2_package_version = node['icinga2']['web2']['version']['icingaweb2'] + node['icinga2']['icinga2_version_suffix']
web2_source_version = 'v' + node['icinga2']['web2']['version']['icingaweb2'].split('-')[0]

if node.attribute?('time') && node['time'].attribute?('timezone')
  timezone = node['time']['timezone']
else
  timezone = 'UTC'
  Chef::Log.warn("missing attribute node['time']['timezone'], using default value 'UTC'")
end

# setup apache and icinga2 vhost
case node['icinga2']['web_engine']
when 'apache'
  include_recipe 'icinga2::server_apache'
else
  raise "unknown web engine '#{node['icinga2']['web_engine']}'"
end

directory node['icinga2']['web2']['conf_dir'] do
  owner node[node['icinga2']['web_engine']]['user']
  group node[node['icinga2']['web_engine']]['group']
  mode '02770'
end

directory node['icinga2']['web2']['log_dir'] do
  owner node[node['icinga2']['web_engine']]['user']
  group node[node['icinga2']['web_engine']]['group']
  mode '0775'
end

# setup token
unless node['icinga2']['web2'].key?('setup_token')
  require 'securerandom'
  node.normal['icinga2']['web2']['setup_token'] = SecureRandom.base64(12)
end

file ::File.join(node['icinga2']['web2']['conf_dir'], 'setup.token') do
  content node['icinga2']['web2']['setup_token']
  owner node[node['icinga2']['web_engine']]['user']
  group node[node['icinga2']['web_engine']]['group']
  mode 0o660
end

# set php time zone
php_ini = if node['platform_family'] =~ /rhel|amazon/
            '/etc/php.ini'
          elsif node['platform_family'] == 'debian'
            if node['lsb']['codename'] == 'xenial'
              '/etc/php/7.0/apache2/php.ini'
            else
              '/etc/php5/apache2/php.ini'
            end
          else
            raise "platform_family #{node['platform_family']} not supported"
          end

ruby_block 'set php timezone' do
  block do
    fe = Chef::Util::FileEdit.new(php_ini)
    fe.search_file_replace_line(/^;date.timezone =.*/, "date.timezone = #{timezone}")
    fe.write_file
  end
end

# install icingaweb2
if node['icinga2']['web2']['install_method'] == 'source'
  package 'icingaweb2' do
    action :remove
  end

  directory node['icinga2']['web2']['web_root'] do
    owner node[node['icinga2']['web_engine']]['user']
    group node[node['icinga2']['web_engine']]['group']
    mode '0775'
  end

  git node['icinga2']['web2']['web_root'] do
    repository node['icinga2']['web2']['source_url']
    revision web2_source_version
    user node[node['icinga2']['web_engine']]['user']
    group node[node['icinga2']['web_engine']]['group']
    only_if { node['icinga2']['web2']['install_method'] == 'source' }
  end

else
  package 'icingaweb2' do
    # skip ubuntu version for now
    version web2_package_version unless node['icinga2']['ignore_version'] || !(node['platform_family'] == 'rhel')
    notifies :restart, 'service[icinga2]', :delayed
  end

  package 'icingacli' do
    version cli_package_version unless node['icinga2']['ignore_version']
    notifies :restart, 'service[icinga2]', :delayed
    only_if { node['platform_family'] == 'rhel' }
  end
end

icinga2_feature 'command'
