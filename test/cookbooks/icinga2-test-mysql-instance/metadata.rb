name 'icinga2-test-mysql-instance'
maintainer 'Vil Surkin'
maintainer_email 'vill.srk@gmail.com'
license 'Apache 2.0'
description 'Installs/Configures test instance of MySQL'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

version '0.0.1'

depends 'mysql', '~> 8.0'
depends 'database', '~> 6.1.1'
depends 'mysql2_chef_gem', '~> 2.0.1'
depends 'yum-mysql-community', '~> 2.1.0'
