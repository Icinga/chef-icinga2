# frozen_string_literal: true
package 'curl' # minimal ubuntu/debian does not come with curl
package 'gnupg' if node['platform'] == 'debian'

icinga2_environment 'test' do
  import node['icinga2']['server']['object']['host']['import']
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
