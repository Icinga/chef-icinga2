
default['icinga2']['ido']['type'] = 'mysql'

default['icinga2']['ido']['db_name'] = 'icinga'
default['icinga2']['ido']['db_user'] = 'icinga'
default['icinga2']['ido']['db_password'] = 'icinga'
default['icinga2']['ido']['db_host'] = 'localhost'
default['icinga2']['ido']['db_port'] = 3306

default['icinga2']['ido']['mysql_schema'] = '/usr/share/icinga2-ido-mysql/schema/mysql.sql'
default['icinga2']['ido']['pgsql_schema'] = '/usr/share/icinga2-ido-pgsql/schema/pgsql.sql'
