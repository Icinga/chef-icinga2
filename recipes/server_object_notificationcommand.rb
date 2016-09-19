# frozen_string_literal: true
#
# Cookbook Name:: icinga2
# Recipe:: server_object_notificationcommand
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

icinga2_notificationcommand 'mail-service-notification' do
  command ['SysconfDir + "/icinga2/scripts/mail-service-notification.sh"']
  env 'NOTIFICATIONTYPE' => '$notification.type$', \
      'SERVICEDESC' => '$service.name$',\
      'HOSTALIAS' => '$host.display_name$',\
      'HOSTADDRESS' => '$address$',\
      'SERVICESTATE' => '$service.state$',\
      'LONGDATETIME' => '$icinga.long_date_time$',\
      'SERVICEOUTPUT' => '$service.output$',\
      'NOTIFICATIONAUTHORNAME' => '$notification.author$',\
      'NOTIFICATIONCOMMENT' => '$notification.comment$',\
      'HOSTDISPLAYNAME' => '$host.display_name$',\
      'SERVICEDISPLAYNAME' => '$service.display_name$',\
      'USEREMAIL' => '$user.email$'
  zone node['icinga2']['server']['object']['global-templates'] ? 'global-templates' : nil
end

# add icinga host notification command
icinga2_notificationcommand 'mail-host-notification' do
  command ['SysconfDir + "/icinga2/scripts/mail-host-notification.sh"']
  env 'NOTIFICATIONTYPE' => '$notification.type$', \
      'SERVICEDESC' => '$service.name$',\
      'HOSTALIAS' => '$host.display_name$',\
      'HOSTADDRESS' => '$address$',\
      'LONGDATETIME' => '$icinga.long_date_time$',\
      'NOTIFICATIONAUTHORNAME' => '$notification.author$',\
      'NOTIFICATIONCOMMENT' => '$notification.comment$',\
      'HOSTDISPLAYNAME' => '$host.display_name$',\
      'USEREMAIL' => '$user.email$',\
      'HOSTSTATE' => '$host.state$',\
      'HOSTOUTPUT' => '$host.output$'
  zone node['icinga2']['server']['object']['global-templates'] ? 'global-templates' : nil
end
