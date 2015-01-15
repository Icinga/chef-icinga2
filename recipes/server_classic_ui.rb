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

case node['platform_family']
when 'debian'
  package 'icinga2-classicui' do
    version node['icinga2']['classic_ui']['version'] + node['icinga2']['icinga2_version_suffix']
  end
when 'rhel'
  package 'icinga2-classicui-config' do
    version node['icinga2']['classic_ui']['version'] + node['icinga2']['icinga2_version_suffix']
  end

  package 'icinga-gui' do
    version node['icinga2']['classic_ui']['gui_version'] + node['icinga2']['icinga2_version_suffix']
  end
end

directory node['icinga2']['classic_ui']['log_dir'] do
  owner 'root'
  group 'root'
  mode 0755
end

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
