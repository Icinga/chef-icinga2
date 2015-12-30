name 'icinga2'
maintainer 'Virender Khatri'
maintainer_email 'vir.khatri@gmail.com'
license 'Apache 2.0'
description 'Installs/Configures Icinga2'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.7.1'

depends 'apt'
depends 'yum', '~> 3.0'
depends 'yum-epel'
depends 'apache2'
depends 'ulimit'
depends 'pnp4nagios'

%w(redhat centos amazon ubuntu debian).each do |os|
  supports os
end
