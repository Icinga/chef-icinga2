
default['icinga2']['server']['db']['type'] = 'mysql'
default['icinga2']['server']['db']['install_mysql_server'] = true
default['icinga2']['server']['db']['install_pgsql_server'] = true

default['icinga2']['server']['db']['db_name'] = 'icinga'
default['icinga2']['server']['db']['db_user'] = 'icinga'
default['icinga2']['server']['db']['db_password'] = 'icinga'
default['icinga2']['server']['db']['db_host'] = 'localhost'
default['icinga2']['server']['db']['db_port'] = 3306

default['icinga2']['server']['db']['mysql_schema'] = '/usr/share/icinga2-ido-mysql/schema/mysql.sql'
default['icinga2']['server']['db']['pgsql_schema'] = '/usr/share/icinga2-ido-mysql/schema/pgsql.sql'
