# frozen_string_literal: true
#
# Cookbook Name:: icinga2
# Recipe:: server_apache
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

node.default['apache']['servertokens'] = 'Minimal'
node.default['apache']['mpm'] = 'prefork'

node['icinga2']['apache_modules'].each { |mod| include_recipe "apache2::#{mod}" }

if node['lsb']['codename'] == 'trusty'
  package 'libapache2-mod-php5' do
    action :install
    notifies :reload, 'service[apache2]', :delayed
  end
end

if (node['platform_family'] == 'debian') && (node['lsb']['codename'] == 'xenial') # ~FC023
  apache_module 'php7.0' do
    conf false
    filename 'libphp7.0.so'
    identifier 'php7_module'
    notifies platform?('windows') ? :restart : :reload, 'service[apache2]'
  end
end

# keeping it to default for now, need
# to look into merging into a single
# vhost config file
apache_conf_file = node['platform_family'] == 'debian' ? 'debian' : 'rhel'
template ::File.join(node['apache']['dir'], 'conf-available', "#{node['icinga2']['classic_ui']['apache_conf']}.conf") do
  source "apache.vhost.icinga2_classic_ui.conf.#{apache_conf_file}.erb"
  owner node['apache']['user']
  group node['apache']['group']
  notifies platform?('windows') ? :restart : :reload, 'service[apache2]', :delayed
  only_if { node['icinga2']['classic_ui']['enable'] }
end

template ::File.join(node['apache']['dir'], 'conf-available', 'icinga2-web2.conf') do
  source 'apache.vhost.icinga2_web2.erb'
  owner node['apache']['user']
  group node['apache']['group']
  notifies platform?('windows') ? :restart : :reload, 'service[apache2]', :delayed
  variables(:web_root => node['icinga2']['web2']['web_root'],
            :web_uri => node['icinga2']['web2']['web_uri'],
            :conf_dir => node['icinga2']['web2']['conf_dir'])
  only_if { node['icinga2']['web2']['enable'] }
end

apache_config node['icinga2']['classic_ui']['apache_conf'] if node['icinga2']['classic_ui']['enable']
apache_config 'icinga2-web2' if node['icinga2']['web2']['enable']

# group resource for user nagios
group node['icinga2']['group'] do
  only_if { node['platform_family'] == 'debian' }
  append true
end

user 'nagios' do
  gid 'nagios'
  system true
  only_if { node['platform_family'] == 'debian' }
end

# add group members
group "manage_members_#{node['icinga2']['group']}" do
  group_name node['icinga2']['group']
  members [node['apache']['user'], node['icinga2']['user']]
  only_if { node['platform_family'] == 'debian' }
  notifies :restart, 'service[apache2]', :delayed
  action :modify
end
