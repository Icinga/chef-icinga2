#
# Cookbook Name:: icinga2
# Recipe:: server_install
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

case node['platform_family']
when 'ubuntu'
  # apt repository configuration
  apt_repository 'icinga2' do
    uri node['icinga2']['apt']['uri']
    distribution node['icinga2']['apt']['distribution']
    components node['icinga2']['apt']['components']
    keyserver node['icinga2']['apt']['keyserver']
    key node['icinga2']['apt']['key']
    deb_src node['icinga2']['apt']['deb_src']
    action node['icinga2']['apt']['action']
  end

  os_packages = %w(g++ php5 php5-cli php5-fpm build-essential libgd2-xpm-dev libjpeg62 libjpeg62-dev libpng12-0 libpng12-dev libapache2-mod-php5)
when 'rhel'
  # yum repository configuration
  yum_repository 'icinga2' do
    description node['icinga2']['yum']['description']
    baseurl node['icinga2']['yum']['baseurl']
    mirrorlist node['icinga2']['yum']['mirrorlist']
    gpgcheck node['icinga2']['yum']['gpgcheck']
    gpgkey node['icinga2']['yum']['gpgkey']
    enabled node['icinga2']['yum']['enabled']
    action node['icinga2']['yum']['action']
  end

  os_packages = %w(gcc gcc-c++ glibc glibc-common mailx php php-devel gd gd-devel libjpeg libjpeg-devel libpng libpng-devel php-gd php-fpm php-cli php-pear php-xmlrpc php-xsl php-pdo php-soap php-ldap php-mysql)
end

# dependencies
os_packages.each do |p|
  package p
end

icinga2_package_version = value_for_platform(
  %w(centos redhat fedora) => { 'default' => ".el#{node['platform_version']}" },
  'amazon' => { 'default' => '.el6' },
  'ubuntu' => { 'default' => '' }
)

# install icinga2 core packages and ido

# Need to revisit below condition,
# might not require to differentiate for different
# platform family

case node['platform_family']
when 'debian'
  %w(icinga2 icinga2-ido-mysql icinga2-ido-pgsql).each do |p|
    package p do
      version node['icinga2']['version']
    end
  end
when 'rhel'
  %w(icinga2 icinga2-ido-mysql icinga2-ido-pgsql).each do |p|
    package p do
      version node['icinga2']['version'] + icinga2_package_version
    end
  end
end
