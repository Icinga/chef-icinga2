#
# Cookbook Name:: icinga2
# Recipe:: client
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

# install nrpe packages
node['icinga2']['client']['packages'].each do |p|
  package p do
    only_if { node['icinga2']['client']['manage'] }
  end
end

directory node['icinga2']['client']['conf_dir'] do
  owner node['icinga2']['client']['user']
  group node['icinga2']['client']['group']
  mode 0755
  recursive true
  only_if { node['icinga2']['client']['manage'] }
end

directory node['icinga2']['client']['nrpe']['include_dir'] do
  owner node['icinga2']['client']['user']
  group node['icinga2']['client']['group']
  mode 0755
  recursive true
  only_if { node['icinga2']['client']['manage'] }
end

template node['icinga2']['client']['conf_file'] do
  owner node['icinga2']['client']['user']
  group node['icinga2']['client']['group']
  mode 0755
  cookbook node['icinga2']['client']['cookbook']
  source node['icinga2']['client']['template']
  variables(:service_name => node['icinga2']['client']['service_name'],
            :pid_dir => node['icinga2']['client']['pid_dir'],
            :port => node['icinga2']['client']['port'],
            :user => node['icinga2']['client']['user'],
            :group => node['icinga2']['client']['group'],
            :nrpe => node['icinga2']['client']['nrpe'],
            :include_dir => node['icinga2']['client']['include_dir'],
            :plugins_dir => node['icinga2']['plugins_dir']
           )
  notifies :restart, 'service[nrpe]', :delayed
  only_if { node['icinga2']['client']['manage'] }
end

template "/etc/init.d/#{node['icinga2']['client']['service_name']}" do
  owner 'root'
  group 'root'
  mode 0755
  source "init.nrpe.cfg.#{node['platform_family']}.erb"
  variables(:conf_file => node['icinga2']['client']['conf_file'])
  notifies :restart, 'service[nrpe]', :delayed
  only_if { node['icinga2']['client']['manage'] }
end

remote_file ::File.join(node['icinga2']['plugins_dir'], 'check_mem.pl') do
  source 'https://raw.githubusercontent.com/justintime/nagios-plugins/master/check_mem/check_mem.pl'
  owner node['icinga2']['client']['user']
  group node['icinga2']['client']['group']
  mode 0755
  action :create_if_missing
end

remote_file ::File.join(node['icinga2']['plugins_dir'], 'check_disk_mounts') do
  source "https://raw.githubusercontent.com/vkhatri/nagios-plugin-check-disk-mounts/master/#{node['platform_family']}/check_disk_mounts"
  owner node['icinga2']['client']['user']
  group node['icinga2']['client']['group']
  mode 0755
end

service 'nrpe' do
  service_name node['icinga2']['client']['service_name']
  supports :start => true, :stop => true, :restart => true, :status => true
  action [:enable, :start]
  only_if { node['icinga2']['client']['manage'] }
end
