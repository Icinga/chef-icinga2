# frozen_string_literal: true
#
# Cookbook Name:: icinga2
# Recipe:: server_objects
#
# Copyright 2014, Virender Khatri
#

# usergroup objects
icinga2_usergroup 'icingaadmins' do
  display_name 'Icinga 2 Admin Group'
  zone node['icinga2']['object']['global-templates'] ? 'global-templates' : nil
end

# user objects
icinga2_user 'generic-user' do
  template true
  zone node['icinga2']['object']['global-templates'] ? 'global-templates' : nil
end

icinga2_user 'icingaadmin' do
  import 'generic-user'
  enable_notifications true
  states %w(OK Warning Critical Unknown)
  types %w(Problem Recovery)
  display_name 'Icinga 2 Admin'
  groups %w(icingaadmins)
  email 'root@localhost'
  zone node['icinga2']['object']['global-templates'] ? 'global-templates' : nil
end

# host objects
icinga2_host 'generic-host' do
  template true
  max_check_attempts node['icinga2']['object']['host']['max_check_attempts']
  check_interval node['icinga2']['object']['host']['check_interval']
  retry_interval node['icinga2']['object']['host']['retry_interval']
  check_command node['icinga2']['object']['host']['check_command']
  zone node['icinga2']['object']['global-templates'] ? 'global-templates' : nil
end

# service objects
icinga2_service 'generic-service' do
  template true
  max_check_attempts node['icinga2']['object']['host']['max_check_attempts']
  check_interval node['icinga2']['object']['host']['check_interval']
  retry_interval node['icinga2']['object']['host']['retry_interval']
  zone node['icinga2']['object']['global-templates'] ? 'global-templates' : nil
end

# notificationcommand objects
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
  zone node['icinga2']['object']['global-templates'] ? 'global-templates' : nil
end

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
  zone node['icinga2']['object']['global-templates'] ? 'global-templates' : nil
end

# timeperiod objects
icinga2_timeperiod '24x7' do
  display_name 'Icinga 2 24x7 TimePeriod'
  ranges 'monday' => '00:00-24:00',
         'tuesday' => '00:00-24:00',
         'wednesday' => '00:00-24:00',
         'thursday' => '00:00-24:00',
         'friday' => '00:00-24:00',
         'saturday' => '00:00-24:00',
         'sunday' => '00:00-24:00'
  zone node['icinga2']['object']['global-templates'] ? 'global-templates' : nil
end

icinga2_timeperiod '9to5' do
  display_name 'Icinga 2 9to5 TimePeriod'
  ranges 'monday' => '09:00-17:00',
         'tuesday'   => '09:00-17:00',
         'wednesday' => '09:00-17:00',
         'thursday'  => '09:00-17:00',
         'friday' => '09:00-17:00'
  zone node['icinga2']['object']['global-templates'] ? 'global-templates' : nil
end

icinga2_timeperiod 'never' do
  display_name 'Icinga 2 never TimePeriod'
  zone node['icinga2']['object']['global-templates'] ? 'global-templates' : nil
end
