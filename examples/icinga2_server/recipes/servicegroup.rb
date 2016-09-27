# frozen_string_literal: true
#
# Cookbook Name:: icinga2_server
# Recipe:: servicegroup
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

icinga2_servicegroup 'nrpe_check_load' do
  display_name 'nrpe_check_load'
  assign_where ['service.name == "nrpe_check_load"']
end

icinga2_servicegroup 'nrpe_check_disk_mounts' do
  display_name 'nrpe_check_disk_mounts'
  assign_where ['service.name == "nrpe_check_disk_mounts"']
end

icinga2_servicegroup 'nrpe_check_zombie_procs' do
  display_name 'nrpe_check_zombie_procs'
  assign_where ['service.name == "nrpe_check_zombie_procs"']
end

icinga2_servicegroup 'nrpe_check_mem' do
  display_name 'nrpe_check_mem'
  assign_where ['service.name == "nrpe_check_mem"']
end
