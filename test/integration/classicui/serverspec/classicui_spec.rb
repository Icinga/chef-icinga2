# frozen_string_literal: true
require 'spec_helper'

packages = %w(icinga2)
if os[:family] == 'redhat'
  webserver = 'httpd'
  packages += %w(icinga2-classicui-config icinga-gui)
  icinga2_http_path = 'icinga'
else
  webserver = 'apache2'
  packages += %w(icinga2-classicui)
  icinga2_http_path = 'cgi-bin/icinga2-classicui/status.cgi'
end

packages.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe service('icinga2') do
  it { should be_running }
  it { should be_enabled }
end

describe service(webserver) do
  it { should be_running }
  it { should be_enabled }
end

# Root path in debian-based distros opened for everyone
# We'll check that explicitly
if os[:family] != 'redhat'
  describe command('curl -IL -u icingaadmin:badpassword localhost/icinga2-classicui') do
    its(:stdout) { should match(%r{HTTP/1.1 200 OK}) }
  end
end

describe command("curl -IL -u icingaadmin:icingaadmin localhost/#{icinga2_http_path}") do
  its(:stdout) { should match(%r{HTTP/1.1 200 OK}) }
end

describe command("curl -IL -u icingaadmin:badpassword localhost/#{icinga2_http_path}") do
  its(:stdout) { should match(%r{HTTP/1.1 401}) }
end
