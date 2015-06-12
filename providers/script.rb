#
# Cookbook Name:: icinga2
# Provider:: script
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
  new_resource.updated_by_last_action(script_template)
end

action :delete do
  new_resource.updated_by_last_action(script_template)
end

protected

def script_template
  t = template ::File.join(node['icinga2']['scripts_dir'], new_resource.name) do
    cookbook new_resource.cookbook if new_resource.cookbook
    source new_resource.source if new_resource.source
    owner node['icinga2']['user']
    group node['icinga2']['group']
    mode 0755
    variables new_resource.variables if new_resource.variables
    action new_resource.action
  end
  t.updated?
end
