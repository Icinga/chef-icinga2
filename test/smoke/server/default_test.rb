# # encoding: utf-8

# Inspec test for recipe icinga2repo::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package('icinga2') do
  it { should be_installed }
end

describe package('icinga2-common') do
  it { should be_installed }
end

describe package('icinga2-bin') do
  it { should be_installed }
end

if %w(redhat fedora amazon).include?(os[:family])
  describe package('icinga2-libs') do
    it { should be_installed }
  end
else
  describe package('libicinga2') do
    it { should be_installed }
  end
end

describe service('icinga2') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
