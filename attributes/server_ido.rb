
default['icinga2']['ido']['type'] = nil
default['icinga2']['ido']['install_mysql_server'] = true
default['icinga2']['ido']['install_pgsql_server'] = true

default['icinga2']['ido']['db_name'] = 'icinga'
default['icinga2']['ido']['db_user'] = 'icinga'
default['icinga2']['ido']['db_password'] = 'icinga'
default['icinga2']['ido']['db_host'] = 'localhost'
default['icinga2']['ido']['db_port'] = 3306

default['icinga2']['ido']['mysql_schema'] = '/usr/share/icinga2-ido-mysql/schema/mysql.sql'
default['icinga2']['ido']['pgsql_schema'] = '/usr/share/icinga2-ido-mysql/schema/pgsql.sql'
