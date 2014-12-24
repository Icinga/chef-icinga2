#
# Cookbook Name:: icinga2
# Provider:: feature
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

action :enable do
  fail "feature not available - #{new_resource.name}" unless ::File.exist?(::File.join(node['icinga2']['features_available_dir'], "#{new_resource.name}.conf"))

  unless ::File.exist?(::File.join(node['icinga2']['features_enabled_dir'], "#{new_resource.name}.conf"))
    r = execute "enable_feature_#{new_resource.name}" do
      command "/usr/sbin/icinga2 feature enable #{new_resource.name}"
      creates ::File.join(node['icinga2']['features_enabled_dir'], "#{new_resource.name}.conf")
      notifies :reload, 'service[icinga2]', :delayed
    end
    new_resource.updated_by_last_action(r.updated?)
  end
end

action :disable do
  if ::File.exist?(::File.join(node['icinga2']['features_enabled_dir'], "#{new_resource.name}.conf"))
    r = execute "disable_feature_#{new_resource.name}" do
      command "/usr/sbin/icinga2 feature disable #{new_resource.name}"
      notifies :reload, 'service[icinga2]', :delayed
    end
    new_resource.updated_by_last_action(r.updated?)
  end
end
