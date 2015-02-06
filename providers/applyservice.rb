#
# Cookbook Name:: icinga2
# Provider:: applyservice
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
    resource.is_a?(Chef::Resource::Icinga2Applyservice)
  end
end

# collect objects and create resource template
def object_template
  # collect objects
  icinga2_objects = {}
  object_resources.reduce({}) do |_hash, resource|
    next if resource.action != :create || icinga2_objects.key?(resource.name)
    icinga2_objects[resource.name] = {}
    icinga2_objects[resource.name] = { 'import' => resource.send('import'),
                                       'display_name' => resource.send('display_name'),
                                       'host_name' => resource.send('host_name'),
                                       'groups' => resource.send('groups'),
                                       'check_command' => resource.send('check_command'),
                                       'max_check_attempts' => resource.send('max_check_attempts'),
                                       'check_period' => resource.send('check_period'),
                                       'check_interval' => resource.send('check_interval'),
                                       'retry_interval' => resource.send('retry_interval'),
                                       'enable_notifications' => resource.send('enable_notifications'),
                                       'enable_active_checks' => resource.send('enable_active_checks'),
                                       'enable_passive_checks' => resource.send('enable_passive_checks'),
                                       'enable_event_handler' => resource.send('enable_event_handler'),
                                       'enable_flapping' => resource.send('enable_flapping'),
                                       'enable_perfdata' => resource.send('enable_perfdata'),
                                       'event_command' => resource.send('event_command'),
                                       'flapping_threshold' => resource.send('flapping_threshold'),
                                       'volatile' => resource.send('volatile'),
                                       'zone' => resource.send('zone'),
                                       'command_endpoint' => resource.send('command_endpoint'),
                                       'notes' => resource.send('notes'),
                                       'notes_url' => resource.send('notes_url'),
                                       'action_url' => resource.send('action_url'),
                                       'icon_image' => resource.send('icon_image'),
                                       'icon_image_alt' => resource.send('icon_image_alt'),
                                       'assign_where' => resource.send('assign_where'),
                                       'ignore_where' => resource.send('ignore_where'),
                                       'custom_vars' => resource.send('custom_vars') }
  end

  # create object resource
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
