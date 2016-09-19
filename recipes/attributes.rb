# frozen_string_literal: true
#
# Cookbook Name:: icinga2
# Recipe:: attributes
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
node.default['icinga2']['classic_ui']['cgi']['authorized_for_system_information'] = node['icinga2']['classic_ui']['authorized_for_system_information'].join(',')
node.default['icinga2']['classic_ui']['cgi']['authorized_for_configuration_information'] = node['icinga2']['classic_ui']['authorized_for_configuration_information'].join(',')
node.default['icinga2']['classic_ui']['cgi']['authorized_for_full_command_resolution'] = node['icinga2']['classic_ui']['authorized_for_full_command_resolution'].join(',')
node.default['icinga2']['classic_ui']['cgi']['authorized_for_system_commands'] = node['icinga2']['classic_ui']['authorized_for_system_commands'].join(',')
node.default['icinga2']['classic_ui']['cgi']['authorized_for_all_services'] = node['icinga2']['classic_ui']['authorized_for_all_services'].join(',')
node.default['icinga2']['classic_ui']['cgi']['authorized_for_all_hosts'] = node['icinga2']['classic_ui']['authorized_for_all_hosts'].join(',')
node.default['icinga2']['classic_ui']['cgi']['authorized_for_all_service_commands'] = node['icinga2']['classic_ui']['authorized_for_all_service_commands'].join(',')
node.default['icinga2']['classic_ui']['cgi']['authorized_for_all_host_commands'] = node['icinga2']['classic_ui']['authorized_for_all_host_commands'].join(',')
