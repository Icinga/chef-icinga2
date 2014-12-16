#
# Cookbook Name:: icinga2
# Provider:: notification
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
    resource.is_a?(Chef::Resource::Icinga2Notification)
  end
end

# collect objects
def objects
  icinga2_objects = {}
  icinga2_templates = {}
  object_resources.reduce({}) do |_hash, resource|
    next unless resource.action == :create
    if resource.send('template') && !icinga2_templates.key?(resource.name)
      icinga2_templates[resource.name] = {}
      icinga2_templates[resource.name] = { 'import' => resource.send('import'),
                                           'host_name' => resource.send('host_name'),
                                           'service_name' => resource.send('service_name'),
                                           'users' => resource.send('users'),
                                           'user_groups' => resource.send('user_groups'),
                                           'times' => resource.send('times'),
                                           'command' => resource.send('command'),
                                           'interval' => resource.send('interval'),
                                           'period' => resource.send('period'),
                                           'zone' => resource.send('zone'),
                                           'types' => resource.send('types'),
                                           'states' => resource.send('states'),
                                           'object_class' => 'template',
                                           'custom_vars' => resource.send('custom_vars')
      }
    elsif !icinga2_objects.key?(resource.name)
      icinga2_objects[resource.name] = {}
      icinga2_objects[resource.name] = { 'import' => resource.send('import'),
                                         'host_name' => resource.send('host_name'),
                                         'service_name' => resource.send('service_name'),
                                         'users' => resource.send('users'),
                                         'user_groups' => resource.send('user_groups'),
                                         'times' => resource.send('times'),
                                         'command' => resource.send('command'),
                                         'interval' => resource.send('interval'),
                                         'period' => resource.send('period'),
                                         'zone' => resource.send('zone'),
                                         'types' => resource.send('types'),
                                         'states' => resource.send('states'),
                                         'object_class' => 'object',
                                         'custom_vars' => resource.send('custom_vars')
      }
    end
  end
  [icinga2_objects, icinga2_templates]
end

# create object resource
def object_template
  objs, tmpls = objects
  ob = template ::File.join(node['icinga2']['objects_dir'], "#{::File.basename(__FILE__, '.rb')}.conf") do
    source "object.#{::File.basename(__FILE__, '.rb')}.conf.erb"
    cookbook 'icinga2'
    owner node['icinga2']['user']
    group node['icinga2']['group']
    mode 0640
    variables(:objects => objs)
    notifies :reload, 'service[icinga2]', :delayed
  end
  te = template ::File.join(node['icinga2']['objects_dir'], "#{::File.basename(__FILE__, '.rb')}_template.conf") do
    source "object.#{::File.basename(__FILE__, '.rb')}.conf.erb"
    cookbook 'icinga2'
    owner node['icinga2']['user']
    group node['icinga2']['group']
    mode 0640
    variables(:objects => tmpls)
    notifies :reload, 'service[icinga2]', :delayed
  end
  ob.updated? || te.updated?
end
