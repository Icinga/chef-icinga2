# frozen_string_literal: true
#
# Cookbook Name:: icinga2
# Recipe:: core_install
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
if platform?('windows')
  chocolatey_package 'icinga2' do
    version node['icinga2']['version']
    action :upgrade
  end
else
  case node['platform_family']
  when 'debian'
    # apt repository configuration
    apt_repository 'icinga2' do
      uri node['icinga2']['apt']['uri']
      distribution node['icinga2']['apt']['distribution']
      components node['icinga2']['apt']['components']
      keyserver node['icinga2']['apt']['keyserver'] unless node['icinga2']['apt']['keyserver'].nil?
      key node['icinga2']['apt']['key']
      deb_src node['icinga2']['apt']['deb_src']
      action node['icinga2']['apt']['action']
    end
  when 'rhel', 'amazon'
    # yum repository configuration
    yum_repository 'icinga2' do
      description node['icinga2']['yum']['description']
      baseurl node['icinga2']['yum']['baseurl']
      mirrorlist node['icinga2']['yum']['mirrorlist'] if node['icinga2']['yum']['mirrorlist']
      gpgcheck node['icinga2']['yum']['gpgcheck']
      gpgkey node['icinga2']['yum']['gpgkey']
      enabled node['icinga2']['yum']['enabled']
      action node['icinga2']['yum']['action']
    end
  end

  # install icinga2 core packages
  package 'icinga2' do
    version node['icinga2']['version'] + node['icinga2']['icinga2_version_suffix'] unless node['icinga2']['ignore_version']
    notifies :restart, 'service[icinga2]', :delayed
  end
end
