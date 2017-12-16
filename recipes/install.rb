# frozen_string_literal: true
#
# Cookbook Name:: icinga2
# Recipe:: core_install
#
# Copyright 2014, Virender Khatri
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
    include_recipe 'apt'
  when 'fedora', 'rhel', 'amazon'
    os_packages = %w(gcc gcc-c++ glibc glibc-common mailx)
    include_recipe 'yum-epel' if node['platform'] != 'amazon' && node['icinga2']['setup_epel']
  end

  os_packages.each do |p|
    package p
  end
end

package 'icinga2' do
  version node['icinga2']['version'] + node['icinga2']['version_suffix'] unless node['icinga2']['ignore_version']
  notifies :restart, 'service[icinga2]', :delayed
end
