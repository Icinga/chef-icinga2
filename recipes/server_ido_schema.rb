#
# Cookbook Name:: icinga2
# Recipe:: server_ido_schema
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

# Note: User need to create DB database, user with grants.

# validate ido
raise "incorrect ido #{node['icinga2']['ido']['type']}, valid are mysql pgsql" unless %w(mysql pgsql).include?(node['icinga2']['ido']['type'])

# install icinga2 ido package
package "icinga2-ido-#{node['icinga2']['ido']['type']}" do
  version node['icinga2']['version'] + node['icinga2']['icinga2_version_suffix'] unless node['icinga2']['ignore_version']
end

# load ido schema
execute 'schema_load_ido_mysql' do
  command "\
  mysql -h #{node['icinga2']['ido']['db_host']} \
  -u#{node['icinga2']['ido']['db_user']} \
  -p#{node['icinga2']['ido']['db_password']} \
  #{node['icinga2']['ido']['db_name']} < /usr/share/icinga2-ido-#{node['icinga2']['ido']['type']}/schema/#{node['icinga2']['ido']['type']}.sql \
  && touch /etc/icinga2/schema_loaded_ido_mysql"
  creates '/etc/icinga2//schema_loaded_ido_mysql'
  environment 'MYSQL_HOME' => node['icinga2']['ido']['mysql_home']
  only_if { node['icinga2']['ido']['load_schema'] && node['icinga2']['ido']['type'] == 'mysql' }
end

execute 'schema_load_ido_pgsql' do
  command "\
  su - postgres -c \"export PGPASSWORD=\'#{node['icinga2']['ido']['db_password']}\' && \
  psql -h #{node['icinga2']['ido']['db_host']}\
  -U #{node['icinga2']['ido']['db_user']}\
  -d #{node['icinga2']['ido']['db_name']} < /usr/share/icinga2-ido-#{node['icinga2']['ido']['type']}/schema/#{node['icinga2']['ido']['type']}.sql \
  && export PGPASSWORD=\'\'\" \
  && touch /var/lib/pgsql/schema_loaded_ido_pgsql"
  creates '/var/lib/pgsql/schema_loaded_ido_pgsql'
  only_if { node['icinga2']['ido']['load_schema'] && node['icinga2']['ido']['type'] == 'pgsql' }
end

# enable icinga2 feature ido
icinga2_feature "ido-#{node['icinga2']['ido']['type']}" if node['icinga2']['ido']['load_schema']
