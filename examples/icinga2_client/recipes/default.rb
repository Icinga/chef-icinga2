#
# Cookbook Name:: icinga2_client
# Recipe:: default
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

check_load_warning = (node['cpu']['total'].to_f * node['icinga2']['client']['nrpe']['checks']['warning']['cpu_load'].to_f).round / 100.0
check_load_critical = (node['cpu']['total'].to_f * node['icinga2']['client']['nrpe']['checks']['critical']['cpu_load'].to_f).round / 100.0

icinga2_nrpe 'check_load' do
  plugin_dir node['icinga2']['plugins_dir']
  plugin_name 'check_load'
  plugin_args "-w #{check_load_warning},#{check_load_warning},#{check_load_warning} -c #{check_load_critical},#{check_load_critical},#{check_load_critical}"
end

icinga2_nrpe 'check_disk_mounts' do
  plugin_dir node['icinga2']['plugins_dir']
  plugin_name 'check_disk_mounts'
  plugin_args "#{node['icinga2']['client']['nrpe']['checks']['warning']['free_disk_percentage']} #{node['icinga2']['client']['nrpe']['checks']['critical']['free_disk_percentage']}"
end

icinga2_nrpe 'check_zombie_procs' do
  plugin_dir node['icinga2']['plugins_dir']
  plugin_name 'check_procs'
  plugin_args "-w #{node['icinga2']['client']['nrpe']['checks']['warning']['zombie_count']} -c #{node['icinga2']['client']['nrpe']['checks']['critical']['zombie_count']} -s Z"
end

icinga2_nrpe 'check_mem' do
  plugin_dir node['icinga2']['plugins_dir']
  plugin_name 'check_mem.pl'
  plugin_args "-f -C -w #{node['icinga2']['client']['nrpe']['checks']['warning']['free_memory_percentage']} -c #{node['icinga2']['client']['nrpe']['checks']['critical']['free_memory_percentage']}"
end
