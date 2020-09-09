# frozen_string_literal: true
name 'icinga2'
maintainer 'Virender Khatri'
maintainer_email 'vir.khatri@gmail.com'
license 'Apache-2.0'
description 'Installs/Configures Icinga2'
version '4.0.0'

chef_version '>= 12.1'

source_url 'https://github.com/Icinga/chef-icinga2'
issues_url 'https://dev.icinga.org/projects/chef-icinga2'

depends 'ulimit', '>= 0.4.0'
depends 'chocolatey', '>= 1.2.1'
depends 'yum-epel', '>= 2.1.1'
depends 'icinga2repo', '>= 1.0.0'

%w(raspbian redhat centos amazon ubuntu debian windows).each do |os|
  supports os
end
