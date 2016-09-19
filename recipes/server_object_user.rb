# frozen_string_literal: true
#
# Cookbook Name:: icinga2
# Recipe:: server_object_user
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

# generic-user user template
icinga2_user 'generic-user' do
  template true
  zone node['icinga2']['server']['object']['global-templates'] ? 'global-templates' : nil
end

# add default icingaadmin user
icinga2_user 'icingaadmin' do
  import 'generic-user'
  enable_notifications true
  states %w(OK Warning Critical Unknown)
  types %w(Problem Recovery)
  display_name 'Icinga 2 Admin'
  groups %w(icingaadmins)
  email 'root@localhost'
  zone node['icinga2']['server']['object']['global-templates'] ? 'global-templates' : nil
end
