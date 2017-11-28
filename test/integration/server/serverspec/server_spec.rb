# frozen_string_literal: true
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
