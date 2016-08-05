require 'spec_helper'

%w(
  icinga2
).each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe service('icinga2') do
  it { should be_running }
  it { should be_enabled }
end

case os[:family]
  when 'centos'
    webserver = 'httpd'
  when 'debian'
    webserver = 'apache2'
  when 'ubuntu'
    webserver = 'apache2'
end

describe service(webserver) do
  it { should be_running }
  it { should be_enabled }
end

describe command('curl -IL -u icingaadmin:icingaadmin localhost/icinga2-classicui') do
  its(:stdout) { should match(%r{HTTP/1.1 200 OK}) }
end
