
# frozen_string_literal: true
default['icinga2']['web2']['enable'] = false
default['icinga2']['web2']['install_method'] = 'package' # source
default['icinga2']['web2']['source_url'] = 'https://github.com/Icinga/icingaweb2.git'
default['icinga2']['web2']['version']['icingaweb2'] = '2.4.1-1'
default['icinga2']['web2']['version']['icingacli'] = '2.4.1-1'
default['icinga2']['web2']['web_root'] = '/usr/share/icingaweb2'
default['icinga2']['web2']['web_uri'] = '/icingaweb2'
default['icinga2']['web2']['conf_dir'] = '/etc/icingaweb2'
default['icinga2']['web2']['log_dir'] = '/var/log/icingaweb2'
