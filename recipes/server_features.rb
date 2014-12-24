#
# Cookbook Name:: icinga2
# Recipe:: server_featues
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

node['icinga2']['enable_features'].sort.uniq.each do |f|
  execute "enable_feature_#{f}" do
    command "/usr/sbin/icinga2 feature enable #{f}"
    creates ::File.join(node['icinga2']['features_enabled_dir'], "#{f}.conf")
    only_if { node['icinga2']['enable_features_recipe'] && ::File.exist?(::File.join(node['icinga2']['features_available_dir'], "#{f}.conf")) }
    notifies :reload, 'service[icinga2]', :delayed
  end
end

# disable all featues not defined to enable
(node['icinga2']['features'].sort.uniq - node['icinga2']['enable_features'].sort.uniq).each do |f|
  execute "disable_feature_#{f}" do
    command "/usr/sbin/icinga2 feature disable #{f}"
    only_if { node['icinga2']['enable_features_recipe'] && ::File.exist?(::File.join(node['icinga2']['features_enabled_dir'], "#{f}.conf")) }
    notifies :reload, 'service[icinga2]', :delayed
  end
end
