#
# Cookbook Name:: icinga2
# Recipe:: server_config
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

include_recipe 'icinga2::core_config'

# mail-service-notification command
template ::File.join(node['icinga2']['scripts_dir'], 'mail-service-notification.sh') do
  cookbook node['icinga2']['cookbook']
  source 'mail-service-notification.sh.erb'
  owner node['icinga2']['user']
  group node['icinga2']['group']
  mode 0o755
end

# mail-host-notification command
template ::File.join(node['icinga2']['scripts_dir'], 'mail-host-notification.sh') do
  cookbook node['icinga2']['cookbook']
  source 'mail-host-notification.sh.erb'
  owner node['icinga2']['user']
  group node['icinga2']['group']
  mode 0o755
end

# icinga2 service user limit
user_ulimit node['icinga2']['user'] do
  filehandle_limit node['icinga2']['limits']['nofile']
  process_limit node['icinga2']['limits']['nproc']
  memory_limit node['icinga2']['limits']['memlock']
end
