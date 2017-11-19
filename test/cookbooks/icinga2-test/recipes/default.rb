# frozen_string_literal: true

icinga2_usergroup 'testgroup' do
  display_name 'Test User Group'
end

icinga2_user 'testuser' do
  import 'generic-user'
  enable_notifications true
  states %w(OK Warning Critical Unknown Up Down)
  types %w(DowntimeStart DowntimeEnd DowntimeRemoved Custom Acknowledgement Problem Recovery FlappingStart FlappingEnd)
  display_name 'Test User'
  groups %w(testgroup)
  email 'testuser@localhost.localdomain'
  period '24x7'
end

icinga2_environment 'test' do
  import node['icinga2']['object']['host']['import']
  environment 'test'
  limit_region true
  ignore_resolv_error true
  enable_cluster_hostgroup true
  enable_application_hostgroup true
  cluster_attribute 'flock'
  application_attribute 'application'
  check_interval '1m'
  retry_interval '10s'
  max_check_attempts 3
end
