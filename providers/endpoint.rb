#
# Cookbook Name:: icinga2
# Provider:: endpoint
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
  new_resource.updated_by_last_action(true) if object_template
end

action :delete do
  new_resource.updated_by_last_action(true) if object_template
end

protected

# collect object defined resources
def object_resources
  run_context.resource_collection.select do |resource|
    resource.is_a?(Chef::Resource::Icinga2Endpoint)
  end
end

# create object resource
def object_template
  # collect objects
  icinga2_objects = {}
  object_resources.reduce({}) do |_hash, resource|
    next if resource.action != :create || icinga2_objects.key?(resource.name)
    icinga2_objects[resource.name] = {}
    icinga2_objects[resource.name] = { 'host' => resource.send('host'),
                                       'port' => resource.send('port'),
                                       'log_duration' => resource.send('log_duration') }
  end

  ot = template ::File.join(node['icinga2']['objects_dir'], "#{::File.basename(__FILE__, '.rb')}.conf") do
    source "object.#{::File.basename(__FILE__, '.rb')}.conf.erb"
    cookbook 'icinga2'
    owner node['icinga2']['user']
    group node['icinga2']['group']
    mode 0640
    variables(:objects => icinga2_objects)
    notifies :reload, 'service[icinga2]', :delayed
  end
  ot.updated?
end
