# frozen_string_literal: true
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

# disable ido-mysql default feature
icinga2_feature 'ido-mysql' do
  action :disable
end

if node['icinga2']['ido']['install_mysql_client']
  case node['platform_family']
  when 'debian'
    # apt repository configuration
    apt_repository 'icinga2-mysql-community' do
      uri node['icinga2']['ido']['apt']['uri']
      distribution node['icinga2']['ido']['apt']['distribution']
      components node['icinga2']['ido']['apt']['components']
      keyserver node['icinga2']['ido']['apt']['keyserver'] unless node['icinga2']['apt']['keyserver'].nil?
      key node['icinga2']['ido']['apt']['key']
      deb_src node['icinga2']['ido']['apt']['deb_src']
      action node['icinga2']['ido']['apt']['action']
    end
  when 'rhel', 'amazon'
    # yum repository configuration
    yum_repository 'icinga2-mysql-community' do
      description node['icinga2']['ido']['yum']['description']
      baseurl node['icinga2']['ido']['yum']['baseurl']
      gpgcheck node['icinga2']['ido']['yum']['gpgcheck']
      gpgkey node['icinga2']['ido']['yum']['gpgkey']
      enabled node['icinga2']['ido']['yum']['enabled']
      action node['icinga2']['ido']['yum']['action']
    end
  end

  package 'mysql-community-client'
end

# load ido schema
execute 'schema_load_ido_mysql' do
  command "\
  mysql -h #{node['icinga2']['ido']['db_host']} \
  -P#{node['icinga2']['ido']['db_port']} \
  -u#{node['icinga2']['ido']['db_user']} \
  -p#{node['icinga2']['ido']['db_password']} \
  #{node['icinga2']['ido']['db_name']} < /usr/share/icinga2-ido-#{node['icinga2']['ido']['type']}/schema/#{node['icinga2']['ido']['type']}.sql \
  && touch /etc/icinga2/schema_loaded_ido_mysql"
  creates '/etc/icinga2//schema_loaded_ido_mysql'
  environment 'MYSQL_HOME' => node['icinga2']['ido']['mysql_home']
  only_if { node['icinga2']['ido']['type'] == 'mysql' }
end

execute 'schema_load_ido_pgsql' do
  command "\
  su - postgres -c \"export PGPASSWORD=\'#{node['icinga2']['ido']['db_password']}\' && \
  psql -h #{node['icinga2']['ido']['db_host']}\
  -p #{node['icinga2']['ido']['db_port']} \
  -U #{node['icinga2']['ido']['db_user']}\
  -d #{node['icinga2']['ido']['db_name']} < /usr/share/icinga2-ido-#{node['icinga2']['ido']['type']}/schema/#{node['icinga2']['ido']['type']}.sql \
  && export PGPASSWORD=\'\'\" \
  && touch /var/lib/pgsql/schema_loaded_ido_pgsql"
  creates '/var/lib/pgsql/schema_loaded_ido_pgsql'
  only_if { node['icinga2']['ido']['type'] == 'pgsql' }
end

# enable icinga2 ido
if node['icinga2']['ido']['type'] == 'mysql'
  icinga2_idomysqlconnection "ido-#{node['icinga2']['ido']['type']}" do
    host node['icinga2']['ido']['db_host']
    port node['icinga2']['ido']['db_port']
    user node['icinga2']['ido']['db_user']
    password node['icinga2']['ido']['db_password']
    database node['icinga2']['ido']['db_name']
  end
elsif node['icinga2']['ido']['type'] == 'pgsql'
  icinga2_idopgsqlconnection "ido-#{node['icinga2']['ido']['type']}" do
    host node['icinga2']['ido']['db_host']
    port node['icinga2']['ido']['db_port']
    user node['icinga2']['ido']['db_user']
    password node['icinga2']['ido']['db_password']
    database node['icinga2']['ido']['db_name']
  end
end
