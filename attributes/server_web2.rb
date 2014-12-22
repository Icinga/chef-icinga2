
default['icinga2']['web2']['enable'] = false
default['icinga2']['web2']['version'] = '1.11.2-1'
default['icinga2']['web2']['web_root'] = '/usr/share/icinga-web2'
default['icinga2']['web2']['home_dir'] = '/etc/icinga-web2'
default['icinga2']['web2']['conf_dir'] = ::File.join(node['icinga2']['web2']['home_dir'], 'conf.d')
