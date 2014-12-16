
default['icinga2']['web']['version'] = '1.11.2-1'
default['icinga2']['web']['web_root'] = '/usr/share/icinga-web'
default['icinga2']['web']['home_dir'] = '/etc/icinga-web'
default['icinga2']['web']['conf_dir'] = ::File.join(node['icinga2']['web']['home_dir'], 'conf.d')
