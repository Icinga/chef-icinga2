# frozen_string_literal: true
require 'spec_helper'

packages = %w(icinga2)
if os[:family] == 'redhat'
  webserver = 'httpd'
  packages += %w(icinga2-classicui-config icinga-gui)
else
  webserver = 'apache2'
  packages += %w(icinga2-classicui)
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
  it { should_not be_running }
  it { should_not be_enabled }
end

describe command('curl -IL -u icingaadmin:icingaadmin localhost/icinga2-classicui') do
  its(:stdout) { should match(%r{HTTP/1.1 200 OK}) }
end
