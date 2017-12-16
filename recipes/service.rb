# frozen_string_literal: true
#
# Cookbook Name:: icinga2
# Recipe:: service
#
# Copyright 2014, Virender Khatri
#

service 'icinga2' do
  service_name node['icinga2']['service_name']
  supports :status => true, :reload => platform?('windows') ? false : true, :restart => true
  action [:enable]
end

ruby_block 'delayed_icinga2_service_start' do
  block do
  end
  notifies :start, 'service[icinga2]', :delayed
end
