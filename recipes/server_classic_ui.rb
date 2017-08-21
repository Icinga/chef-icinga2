# frozen_string_literal: true
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

# setup apache and icinga2 vhost
case node['icinga2']['web_engine']
when 'apache'
  include_recipe 'icinga2::server_apache'
else
  raise "unknown web engine '#{node['icinga2']['web_engine']}'"
end

case node['platform_family']
when 'debian'
  package 'icinga2-classicui' do
    version node['icinga2']['classic_ui']['version'] + node['icinga2']['icinga2_version_suffix'] unless node['icinga2']['ignore_version']
  end
when 'rhel', 'amazon'
  package 'icinga2-classicui-config' do
    version node['icinga2']['classic_ui']['version'] + node['icinga2']['icinga2_version_suffix'] unless node['icinga2']['ignore_version']
  end

  package 'icinga-gui' do
    version node['icinga2']['classic_ui']['gui_version'] + node['icinga2']['icinga2_version_suffix'] unless node['icinga2']['ignore_version']
  end
end

directory node['icinga2']['classic_ui']['log_dir'] do
  owner node['icinga2']['user']
  group node['icinga2']['cmdgroup']
  mode 0o755
end

directory node['icinga2']['classic_ui']['cgi_log_dir'] do
  owner node['icinga2']['user']
  group node['icinga2']['cmdgroup']
  mode 0o2775
end

template ::File.join(node['icinga2']['classic_ui']['conf_dir'], 'cgi.cfg') do
  source 'icinga2.cgi.cfg.erb'
  owner 'root'
  group 'root'
  mode 0o644
  variables(:options => node['icinga2']['classic_ui']['cgi'])
end

template ::File.join(node['icinga2']['classic_ui']['conf_dir'], 'resources.cfg') do
  source 'icinga2.resources.cfg.erb'
  owner 'root'
  group 'root'
  mode 0o644
  variables(:plugins_dir => node['icinga2']['plugins_dir'])
end

template 'icinga2_classic_ui_htpasswd' do
  path value_for_platform(
    %w(centos redhat fedora amazon) => { 'default' => ::File.join(node['icinga2']['classic_ui']['conf_dir'], 'passwd') },
    %w(debian ubuntu) => { 'default' => ::File.join(node['icinga2']['classic_ui']['conf_dir'], 'htpasswd.users') }
  )
  source 'icinga2.passwd.erb'
  owner 'root'
  group node['apache']['group']
  variables(:users => node['icinga2']['classic_ui']['users'])
  mode 0o640
end
