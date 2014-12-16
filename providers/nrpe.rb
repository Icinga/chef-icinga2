#
# Cookbook Name:: icinga2
# Provider:: nrpe
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

def whyrun_supported?
  true
end

action :create do
  fail "#{new_resource.plugin_dir} plugin dir does not exists" unless ::File.exist?(new_resource.plugin_dir)
  fail "#{new_resource.plugin_name} plugin file does not exists" unless ::File.exist?(::File.join(new_resource.plugin_dir, new_resource.plugin_name))

  t = template ::File.join(node['icinga2']['client']['nrpe']['include_dir'], new_resource.command_name + '.cfg') do
    cookbook 'icinga2'
    owner node['icinga2']['client']['user']
    group node['icinga2']['client']['group']
    mode 0755
    source 'nrpe.plugin.cfg.erb'
    variables(:plugin_name => new_resource.plugin_name,
              :plugin_dir => new_resource.plugin_dir,
              :command_name => new_resource.command_name,
              :plugin_args => new_resource.plugin_args)
    notifies :restart, 'service[nrpe]', :delayed
  end
  new_resource.updated_by_last_action(t.updated?)
end

action :delete do
  f = file ::File.join(node['icinga2']['client']['nrpe']['include_dir'], new_resource.command_name + '.cfg') do
    action :delete
  end
  new_resource.updated_by_last_action(f.updated?)
end
