# frozen_string_literal: true
#
# Cookbook:: icinga2
# Recipe:: core_install
#
# Copyright:: 2014, Virender Khatri
#

if platform?('windows')
  chocolatey_package 'icinga2' do
    version node['icinga2']['version']
    action :upgrade
  end
else
  include_recipe 'icinga2repo::default'
end

os_packages = []

unless platform?('windows')
  case node['platform_family']
  when 'debian'
    os_packages = %w(g++ mailutils build-essential)
  when 'fedora', 'rhel', 'amazon'
    os_packages = %w(gcc gcc-c++ glibc glibc-common mailx)
    include_recipe 'yum-epel' if !platform?('amazon') && node['icinga2']['setup_epel']
  end

  os_packages.each do |p|
    package p
  end
end

if platform_family?('debian')
  package 'libicinga2' do
    version node['icinga2']['version'] + node['icinga2']['version_suffix'] unless node['icinga2']['ignore_version']
    options node['icinga2']['package_options']
    action :install
  end if Gem::Version.new(node['icinga2']['version']) < Gem::Version.new('2.10')
end

package 'icinga2-bin' do
  version node['icinga2']['version'] + node['icinga2']['version_suffix'] unless node['icinga2']['ignore_version']
  options node['icinga2']['package_options']
  action :install
end

package 'icinga2' do
  version node['icinga2']['version'] + node['icinga2']['version_suffix'] unless node['icinga2']['ignore_version']
  options node['icinga2']['package_options']
  notifies :restart, 'service[icinga2]', :delayed
end

package 'icinga2-doc' do
  version node['icinga2']['version'] + node['icinga2']['version_suffix'] unless node['icinga2']['ignore_version']
  options node['icinga2']['package_options']
  action :install
end

package 'icinga2-common' do
  version node['icinga2']['version'] + node['icinga2']['version_suffix'] unless node['icinga2']['ignore_version']
  options node['icinga2']['package_options']
  action :install
end
