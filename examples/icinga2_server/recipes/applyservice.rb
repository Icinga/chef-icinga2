# frozen_string_literal: true
#
# Cookbook Name:: icinga2_server
# Recipe:: applyservice
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

# add nrpe check to all nrpe enabled nodes.
# e.g. add nrpe checks for nodes, node['icinga2']['client']['custom_vars']['nrpe'] = true
icinga2_applyservice 'nrpe_check_load' do
  import 'generic-service'
  check_command 'nrpe'
  custom_vars :nrpe_command => 'check_load'
  assign_where ['host.vars.nrpe']
end

icinga2_applyservice 'nrpe_check_disk_mounts' do
  import 'generic-service'
  check_command 'nrpe'
  custom_vars :nrpe_command => 'check_disk_mounts'
  assign_where ['host.vars.nrpe']
end

icinga2_applyservice 'nrpe_check_zombie_procs' do
  import 'generic-service'
  check_command 'nrpe'
  custom_vars :nrpe_command => 'check_zombie_procs'
  assign_where ['host.vars.nrpe']
end

icinga2_applyservice 'nrpe_check_mem' do
  import 'generic-service'
  check_command 'nrpe'
  custom_vars :nrpe_command => 'check_mem'
  assign_where ['host.vars.nrpe']
end
