#
# Cookbook Name:: icinga2
# Recipe:: server_ido
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

node['icinga2']['server']['db']['type']

schema_file = node['icinga2']['server']['db']["#{node['icinga2']['server']['db']['type']}_schema"]
fail "#{node['icinga2']['server']['db']['type']} is not a valid sql db type, supported sql db types are mysql, pgsql" unless %w(mysql pgsql).include?(ode['icinga2']['server']['db']['type'])

execute "icinga2_ido_#{node['icinga2']['server']['db']['type']}_schema" do
  cwd '/tmp'
  case node['icinga2']['server']['db']['type']
  when 'mysql'
    command "mysql -u #{node['icinga2']['server']['db']['db_user']} -p#{node['icinga2']['server']['db']['db_password']} -h #{node['icinga2']['server']['db']['db_host']} #{node['icinga2']['server']['db']['db_name']} < #{schema_file} && touch /etc/icinga2/icinga2_ido_#{node['icinga2']['server']['db']['type']}_schema_loaded"
  when 'pgsql'
    command "su - postgres -c 'export PGPASSWORD='\\''#{node['icinga2']['server']['db']['db_password']}'\\'' && psql -U #{node['icinga2']['server']['db']['db_user']} -h #{node['icinga2']['server']['db']['db_host']} -d #{node['icinga2']['server']['db']['db_name']} < #{schema_file}' && unset PGPASSWORD && /etc/icinga2/icinga2_ido_#{node['icinga2']['server']['db']['type']}_schema_loaded"
  end
  creates "/etc/icinga2/icinga2_ido_#{node['icinga2']['server']['db']['type']}_schema_loaded"
  notifies :reload, 'service[icinga2]', :delayed
end

execute "icinga2_ido_#{node['icinga2']['server']['db']['type']}_enable" do
  cwd '/tmp'
  command "'/usr/sbin/icinga2-enable-feature ido-#{node['icinga2']['server']['db']['type']} && touch /etc/icinga2/icinga2_ido_#{node['icinga2']['server']['db']['type']}_enabled"
  creates "/etc/icinga2/icinga2_ido_#{node['icinga2']['server']['db']['type']}_enabled"
  notifies :reload, 'service[icinga2]', :delayed
end
