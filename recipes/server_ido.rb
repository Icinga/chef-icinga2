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

fail "#{node['icinga2']['ido']['type']} is not a valid sql db type, supported sql db types are mysql, pgsql" if node['icinga2']['ido']['type'] && !%w(mysql pgsql).include?(node['icinga2']['ido']['type'])

# create steps to configure db
template ::File.join(node['icinga2']['scripts_dir'], "configure_icinga2_ido_mysql") do
  owner node['icinga2']['user']
  group node['icinga2']['group']
  source 'configure_icinga2_ido_mysql.erb'
  mode 0600
  variables(:db_host => node['icinga2']['ido']['db_host'],
            :db_name => node['icinga2']['ido']['db_name'],
            :db_user => node['icinga2']['ido']['db_user'],
            :db_password => node['icinga2']['ido']['db_password'],
            :schema_file => '/usr/share/icinga2-ido-mysql/schema/mysql.sql'
           )
end

template ::File.join(node['icinga2']['scripts_dir'], "configure_icinga2_ido_pgsql") do
  owner node['icinga2']['user']
  group node['icinga2']['group']
  source 'configure_icinga2_ido_pgsql.erb'
  mode 0600
  variables(:db_host => node['icinga2']['ido']['db_host'],
            :db_name => node['icinga2']['ido']['db_name'],
            :db_user => node['icinga2']['ido']['db_user'],
            :db_password => node['icinga2']['ido']['db_password'],
            :schema_file => '/usr/share/icinga2-ido-mysql/schema/pgsql.sql'
           )
end
