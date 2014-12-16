default['icinga2']['client']['manage'] = false
default['icinga2']['client']['user'] = 'nagios'
default['icinga2']['client']['group'] = 'nagios'
default['icinga2']['client']['cookbook'] = 'icinga2'
default['icinga2']['client']['template'] = 'nrpe.cfg.erb'
default['icinga2']['client']['port'] = '5666'

default['icinga2']['client']['packages'] = value_for_platform(
  %w(centos redhat fedora amazon) => { 'default' => %w(nrpe nagios-plugins-all nagios-plugins-nrpe) },
  %w(ubuntu) => { 'default' => %w(nagios-nrpe-server nagios-plugins nagios-plugins-basic nagios-plugins-standard nagios-snmp-plugins nagios-plugins-extra nagios-nrpe-plugin),
                  '14.04' => %w(nagios-nrpe-server nagios-plugins nagios-plugins-basic nagios-plugins-standard nagios-snmp-plugins nagios-plugins-extra nagios-nrpe-plugin nagios-plugins-common nagios-plugins-contrib)
}
)

default['icinga2']['client']['service_name'] = value_for_platform_family(
  'debian' => 'nagios-nrpe-server',
  'rhel' => 'nrpe'
)

default['icinga2']['client']['conf_dir'] = value_for_platform_family(
  'debian' => '/etc/nrpe',
  'rhel' => '/etc/nagios'
)

default['icinga2']['client']['conf_file'] = ::File.join(node['icinga2']['client']['conf_dir'], 'nrpe.cfg')

default['icinga2']['client']['nrpe']['allow_arguments'] = 0
default['icinga2']['client']['nrpe']['allowed_hosts'] = %w(localhost 127.0.0.1)
default['icinga2']['client']['nrpe']['debug'] = 0
default['icinga2']['client']['nrpe']['command_timeout'] = 60
default['icinga2']['client']['nrpe']['connection_timeout'] = 300
default['icinga2']['client']['nrpe']['include_dir'] = ::File.join(node['icinga2']['client']['conf_dir'], 'nrpe.d')

default['icinga2']['client']['custom_vars'] = {}
