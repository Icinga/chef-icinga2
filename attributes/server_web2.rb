
default['icinga2']['web2']['enable'] = false
default['icinga2']['web2']['install_method'] = 'git'
default['icinga2']['web2']['package_action'] = 'upgrade' # use 'install' to avoid upgrades
default['icinga2']['web2']['package_version'] = '2.0.0'  # ignored if upgrade is used
default['icinga2']['web2']['web_uri'] = '/icingaweb2'
default['icinga2']['web2']['conf_dir'] = '/etc/icingaweb2'
default['icinga2']['web2']['log_dir'] = '/var/log/icingaweb2'

# To use versions from GitHub, set 'install_method' to 'git'
default['icinga2']['web2']['source_url'] = 'git://git.icinga.org/icingaweb2.git'
default['icinga2']['web2']['version'] = 'v2.0.0'      # or 'HEAD'
default['icinga2']['web2']['git_action'] = 'checkout' # or 'sync' to stay up to date
default['icinga2']['web2']['web_root'] = '/usr/share/icingaweb2'
