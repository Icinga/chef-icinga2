require 'serverspec'

set :backend, :exec
set :path, '$PATH:/sbin:/usr/local/sbin'

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
  describe file('/etc/httpd/conf-enabled/icinga2-web2.conf') do
    it { should be_file }
  end
when 'debian'
  describe file('/etc/apache2/conf-enabled/icinga2-web2.conf') do
    it { should be_file }
  end
when 'ubuntu'
  describe file('/etc/apache2/conf-enabled/icinga2-web2.conf') do
    it { should be_file }
  end
end

describe command('curl -IL localhost/icingaweb2/setup') do
  its(:stdout) { should match(%r{HTTP/1.1 200 OK}) }
end
