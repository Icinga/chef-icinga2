# frozen_string_literal: true
#
# Cookbook Name:: icinga2
# Recipe:: default
#
# Copyright 2014, Virender Khatri
#

include_recipe 'icinga2::install'
include_recipe 'icinga2::config'
include_recipe 'icinga2::objects' if node['icinga2']['disable_conf_d']
include_recipe 'icinga2::service'
