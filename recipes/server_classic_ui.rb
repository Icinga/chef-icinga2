#
# Cookbook Name:: icinga2
# Recipe:: server_classic_ui
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

directory node['icinga2']['classic_ui']['log_dir'] do
  owner 'root'
  group 'root'
  mode 0755
end

# directory node['icinga2']['classic_ui']['cgi_log_dir'] do
#  owner node['icinga2']['user']
#  group node['icinga2']['cmdgroup']
#  mode 0766 #  drwxrwsr-x 2 icinga icingacmd 4096 Nov 23 06:40 /var/log/icinga/gui
# end

template ::File.join(node['icinga2']['classic_ui']['conf_dir'], 'cgi.cfg') do
  source 'icinga2.cgi.cfg.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables(:options => node['icinga2']['classic_ui']['cgi'])
end

template ::File.join(node['icinga2']['classic_ui']['conf_dir'], 'resources.cfg') do
  source 'icinga2.resources.cfg.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables(:plugins_dir => node['icinga2']['plugins_dir'])
end

template ::File.join(node['icinga2']['classic_ui']['conf_dir'], 'passwd') do
  source 'icinga2.passwd.erb'
  owner 'root'
  group node['apache2']['group']
  variables(:users => node['icinga2']['classic_ui']['users'])
  mode 0640
end
