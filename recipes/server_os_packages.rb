#
# Cookbook Name:: icinga2
# Recipe:: server_os_packages
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
when 'debian'
  # package libjpeg62-dev conflicts with libgd2-xpm-dev
  # perhaps can be removed.
  os_packages = %w(g++ mailutils php5 php5-cli php5-fpm build-essential libgd2-xpm-dev libjpeg62 libjpeg62-dev libpng12-0 libpng12-dev libapache2-mod-php5 git-core)
  include_recipe 'apt'
when 'rhel'
  os_packages = %w(gcc gcc-c++ glibc glibc-common mailx php php-devel gd gd-devel libjpeg libjpeg-devel libpng libpng-devel php-gd php-fpm php-cli php-pear php-xmlrpc php-xsl php-pdo php-soap php-ldap php-mysql php-pgsql php-intl git ImageMagick ImageMagick-devel)
end

# dependencies
os_packages.each do |p|
  package p
end

# install the imagick package via pecl
execute 'install imagick' do
  command "printf \'\\n\' | pecl install imagick && echo \"extension=imagick.so\" > /etc/php.d/imagick.ini && touch /etc/php.d/imagick_installed"
  only_if { node['platform_family'] == 'rhel' }
  creates '/etc/php.d/imagick_installed'
end
