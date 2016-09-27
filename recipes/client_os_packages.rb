# frozen_string_literal: true
#
# Cookbook Name:: icinga2
# Recipe:: client_os_packages
#
# Copyright 2014, Virender Khatri
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# install packages for icinga2 / classicui2 / web2

case node['platform_family']
when 'debian'
  # package libjpeg62-dev conflicts with libgd2-xpm-dev
  # perhaps can be removed.
  os_packages = %w(g++ mailutils build-essential)
  include_recipe 'apt'
when 'rhel'
  os_packages = %w(gcc gcc-c++ glibc glibc-common mailx)
  # yum epel repository is required for php-pecl-imagick
  include_recipe 'yum-epel' if node['platform'] != 'amazon' && node['icinga2']['setup_epel']
end

# dependencies
os_packages.each do |p|
  package p
end
