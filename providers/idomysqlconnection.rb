#
# Cookbook Name:: icinga2
# Provider:: idomysqlconnection
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

# create object resource
def object_template
  ot = template ::File.join(node['icinga2']['objects_dir'], "#{::File.basename(__FILE__, '.rb')}.conf") do
    source "object.#{::File.basename(__FILE__, '.rb')}.conf.erb"
    cookbook 'icinga2'
    owner node['icinga2']['user']
    group node['icinga2']['group']
    mode 0640
    variables(:object => new_resource.name,
              :library => new_resource.library,
              :host => new_resource.host,
              :port => new_resource.port,
              :user => new_resource.user,
              :password => new_resource.password,
              :database => new_resource.database,
              :table_prefix => new_resource.table_prefix,
              :instance_name => new_resource.instance_name,
              :instance_description => new_resource.instance_description,
              :enable_ha => new_resource.enable_ha,
              :failover_timeout => new_resource.failover_timeout,
              :cleanup => new_resource.cleanup,
              :categories => new_resource.categories)
    notifies :reload, 'service[icinga2]', :delayed
  end
  ot.updated?
end
