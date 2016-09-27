# frozen_string_literal: true
default['icinga2']['ido']['load_schema'] = false
default['icinga2']['ido']['install_mysql_client'] = false

default['icinga2']['ido']['type'] = 'mysql'
default['icinga2']['ido']['db_host'] = 'localhost'
default['icinga2']['ido']['db_port'] = 3306
default['icinga2']['ido']['db_name'] = 'icinga'
default['icinga2']['ido']['db_user'] = 'icinga'
default['icinga2']['ido']['db_password'] = 'icinga'
default['icinga2']['ido']['mysql_home'] = '/etc/mysql'

# configure mysql official repo to install mysql client package
default['icinga2']['ido']['mysql_version'] = '5.7'

default['icinga2']['ido']['yum']['description'] = "MySQL Community #{node['icinga2']['ido']['mysql_version']}"
default['icinga2']['ido']['yum']['gpgcheck'] = true
default['icinga2']['ido']['yum']['enabled'] = true
default['icinga2']['ido']['yum']['gpgkey'] = 'https://raw.githubusercontent.com/Icinga/chef-icinga2/master/files/default/mysql_pubkey.asc'
default['icinga2']['ido']['yum']['action'] = :create
default['icinga2']['ido']['yum']['baseurl'] = "http://repo.mysql.com/yum/mysql-#{node['icinga2']['ido']['mysql_version']}-community/el/#{node['platform_version'].split('.')[0]}/$basearch/"

default['icinga2']['ido']['apt']['repo'] = "MySQL Community #{node['icinga2']['ido']['mysql_version']}"
default['icinga2']['ido']['apt']['keyserver'] = 'keyserver.ubuntu.com'
default['icinga2']['ido']['apt']['components'] = ["mysql-#{node['icinga2']['ido']['mysql_version']}"]
default['icinga2']['ido']['apt']['deb_src'] = false
default['icinga2']['ido']['apt']['action'] = :add
default['icinga2']['ido']['apt']['repo'] = "MySQL Community #{node['icinga2']['ido']['mysql_version']}"
default['icinga2']['ido']['apt']['uri'] = "http://repo.mysql.com/apt/#{node['platform']}/"
default['icinga2']['ido']['apt']['distribution'] = node['lsb']['codename']
default['icinga2']['ido']['apt']['key'] = '5072E1F5'
