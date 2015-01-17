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

node.default['apache']['servertokens']    = 'Minimal'

include_recipe 'apache2::default'
include_recipe 'apache2::mod_python'
include_recipe 'apache2::mod_php5'
include_recipe 'apache2::mod_cgi'
include_recipe 'apache2::mod_ssl'
include_recipe 'apache2::mod_rewrite'

template ::File.join(node['apache']['dir'], 'conf-available', 'icinga2-classic-ui.conf') do
  source 'apache.vhost.icinga2_classic_ui.conf.erb'
  owner node['apache']['user']
  group node['apache']['group']
  notifies :reload, 'service[apache2]', :delayed
end

template ::File.join(node['apache']['dir'], 'conf-available', 'icinga2-web2.conf') do
  source 'apache.vhost.icinga2_web2.erb'
  owner node['apache']['user']
  group node['apache']['group']
  notifies :reload, 'service[apache2]', :delayed
  variables(:web_root => node['icinga2']['web2']['web_root'],
            :web_uri => node['icinga2']['web2']['web_uri'],
            :conf_dir => node['icinga2']['web2']['conf_dir'])
end

apache_config 'icinga2-classic-ui'
apache_config 'icinga2-web2'
