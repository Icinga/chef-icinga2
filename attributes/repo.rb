
default['icinga2']['yum']['description'] = 'ICINGA Stable Release'
default['icinga2']['yum']['mirrorlist'] = nil
default['icinga2']['yum']['gpgcheck'] = true
default['icinga2']['yum']['enabled'] = true
default['icinga2']['yum']['gpgkey'] = 'http://packages.icinga.org/icinga.key'
default['icinga2']['yum']['action'] = :create

default['icinga2']['yum']['baseurl'] = value_for_platform(
  %w(centos redhat fedora) => { 'default' => 'http://packages.icinga.org/epel/$releasever/release/' },
  'amazon' => { 'default' => 'http://packages.icinga.org/epel/6/release/' }
)

# case node['platform']
# when 'redhat', 'centos'
#  default['icinga2']['yum']['baseurl'] = 'http://packages.icinga.org/epel/$releasever/release/'
# when 'amazon'
#  default['icinga2']['yum']['baseurl'] = 'http://packages.icinga.org/epel/6/release/'
# end

default['icinga2']['apt']['repo'] = 'ICINGA Stable Release'
default['icinga2']['apt']['uri'] = 'http://ppa.launchpad.net/formorer/icinga/ubuntu'
default['icinga2']['apt']['distribution'] = node['lsb']['codename']
default['icinga2']['apt']['keyserver'] = 'keyserver.ubuntu.com'
default['icinga2']['apt']['components'] = %w(main)
default['icinga2']['apt']['deb_src'] = true
default['icinga2']['apt']['repo_key'] = 'http://packages.icinga.org/icinga.key'
default['icinga2']['apt']['action'] = :add
