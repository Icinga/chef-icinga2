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

web2_version = node['icinga2']['web2']['install_method'] == 'source' ? 'v' + node['icinga2']['web2']['version'] : node['icinga2']['web2']['version'] + '-' + node['icinga2']['web2']['release'] + node['icinga2']['icinga2_version_suffix'].to_s
cli_version = node['icinga2']['web2']['version'] + '-' + node['icinga2']['web2']['release'] + node['icinga2']['icinga2_version_suffix']

puts web2_version

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
php_ini = node['platform_family'] == 'rhel' ? '/etc/php.ini' : '/etc/php5/apache2/php.ini'
execute 'Setup Apache2 PHP5' do
  command "sudo sed -i -e 's/;date.timezone =/date.timezone = UTC/g' /etc/php5/apache2/php.ini"
  action :run
  only_if {File.exists?('/etc/php5/apache2/php.ini')}
  notifies :reload, 'service[apache2]', :immediately
end

execute 'Setup Apache2 PHP5.5' do
  command "sudo sed -i -e 's/;date.timezone =/date.timezone = UTC/g' /etc/php/5.5/apache2/php.ini"
  action :run
  only_if {File.exists?('/etc/php/5.5/apache2/php.ini')}
  notifies :reload, 'service[apache2]', :immediately
end

execute 'Setup Apache2 PHP' do
  command "sudo sed -i -e 's/;date.timezone =/date.timezone = UTC/g' /etc/php/5.5/apache2/php.ini"
  action :run
  only_if {File.exists?('/etc/php.ini')}
  notifies :reload, 'service[apache2]', :immediately
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
    revision web2_version
    user node[node['icinga2']['web_engine']]['user']
    group node[node['icinga2']['web_engine']]['group']
    only_if { node['icinga2']['web2']['install_method'] == 'source' }
  end

else
  package 'icingaweb2' do
    # skip ubuntu version for now
    version web2_version if node['platform_famil'] == 'rhel'
    notifies :restart, 'service[icinga2]', :delayed
  end

  package 'icingacli' do
    version cli_version
    notifies :restart, 'service[icinga2]', :delayed
    only_if { node['platform_family'] == 'rhel' }
  end
end

icinga2_feature 'command'
