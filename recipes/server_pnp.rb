# frozen_string_literal: true
#
# Cookbook Name:: icinga2
# Recipe:: server_pnp
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

node.normal['pnp4nagios']['user'] = node['icinga2']['user']
node.normal['pnp4nagios']['group'] = node['icinga2']['cmdgroup']
node.normal['pnp4nagios']['nagios_base'] = '/icinga/cgi-bin'
node.normal['pnp4nagios']['spool_dir'] = node['icinga2']['perfdata_dir']
node.normal['pnp4nagios']['auth_file'] = value_for_platform(
  %w(centos redhat fedora amazon) => { 'default' => ::File.join(node['icinga2']['classic_ui']['conf_dir'], 'passwd') },
  'ubuntu' => { 'default' => ::File.join(node['icinga2']['classic_ui']['conf_dir'], 'htpasswd.users') }
)

include_recipe 'pnp4nagios::default'

directory '/usr/share/icinga/ssi'

link '/usr/share/icinga/ssi/status-header.ssi' do
  to ::File.join(node['pnp4nagios']['source_dir'], 'contrib/ssi/status-header.ssi')
end
