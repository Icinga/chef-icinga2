# frozen_string_literal: true
require 'spec_helper'

%w(
  icinga2
  icinga2-ido-mysql
).each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

case os[:family]
when 'centos'
  webserver_config = '/etc/httpd/conf-enabled/icinga2-web2.conf'
when 'debian'
  webserver_config = '/etc/apache2/conf-enabled/icinga2-web2.conf'
when 'ubuntu'
  webserver_config = '/etc/apache2/conf-enabled/icinga2-web2.conf'
end

describe file(webserver_config) do
  it { should be_file }
end

describe command('curl -IL localhost/icingaweb2/setup') do
  its(:stdout) { should match(%r{HTTP/1.1 200 OK}) }
end
