# frozen_string_literal: true
# http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/getting-started#getting-started

default['icinga2']['version'] = value_for_platform(
  %w(centos redhat fedora amazon) => { 'default' => '2.7.0-1' },
  %w(debian ubuntu raspbian) => { 'default' => '2.7.0-1' },
  %w(windows) => { 'default' => '2.7.0' }
)

default['icinga2']['enable_env_pki'] = false
default['icinga2']['enable_env_custom_pki'] = false
default['icinga2']['ignore_version'] = false
default['icinga2']['cookbook'] = 'icinga2'

default['icinga2']['conf_dir'] = if node['platform'] == 'windows'
                                   'C:/ProgramData/icinga2/etc/icinga2'
                                 else
                                   '/etc/icinga2'
                                 end

default['icinga2']['conf_d_dir'] = ::File.join(node['icinga2']['conf_dir'], 'conf.d')
default['icinga2']['pki_dir'] = ::File.join(node['icinga2']['conf_dir'], 'pki')
default['icinga2']['scripts_dir'] = ::File.join(node['icinga2']['conf_dir'], 'scripts')
default['icinga2']['zones_dir'] = ::File.join(node['icinga2']['conf_dir'], 'zones.d')

default['icinga2']['pnp'] = false

# avoid conflicts
default['icinga2']['disable_conf_d'] = true
default['icinga2']['disable_repository_d'] = false
default['icinga2']['add_cloud_custom_vars'] = true
default['icinga2']['add_inet_custom_vars'] = false

# itl defaults
default['icinga2']['include_itl'] = if node['platform'] == 'windows'
                                      %w(itl plugins-windows)
                                    else
                                      %w(itl plugins)
                                    end

# includes yum-epel cookbook to setup yum epel repository
default['icinga2']['setup_epel'] = true

# object conf file location
default['icinga2']['objects_d'] = 'objects.d'
default['icinga2']['objects_dir'] = ::File.join(node['icinga2']['conf_dir'], node['icinga2']['objects_d'])

# user defined icing2 object / configuration
default['icinga2']['user_defined_objects_dir'] = %w(user_defined_objects)

default['icinga2']['features_enabled_dir'] = ::File.join(node['icinga2']['conf_dir'], 'features-enabled')
default['icinga2']['features_available_dir'] = ::File.join(node['icinga2']['conf_dir'], 'features-available')

default['icinga2']['cluster_attribute'] = nil
default['icinga2']['application_attribute'] = nil
default['icinga2']['enable_cluster_hostgroup'] = true
default['icinga2']['enable_application_hostgroup'] = true
default['icinga2']['enable_role_hostgroup'] = false
default['icinga2']['limit_region'] = true

# host attribute to use for Host Object
# attribute display_name in LWRP environment
default['icinga2']['host_display_name_attr'] = 'hostname'
default['icinga2']['use_fqdn_resolv'] = false
default['icinga2']['failover_fqdn_address'] = true
default['icinga2']['ignore_node_error'] = false
default['icinga2']['ignore_resolv_error'] = true

default['icinga2']['web_engine'] = 'apache'

# icinga2 resources data bag
default['icinga2']['databag'] = 'icinga2'

default['icinga2']['var_dir'] = if node['platform'] == 'windows'
                                  'C:/ProgramData/icinga2/var'
                                else
                                  '/var'
                                end

default['icinga2']['run_dir'] = ::File.join(node['icinga2']['var_dir'], 'run/icinga2')
default['icinga2']['run_cmd_dir'] = ::File.join(node['icinga2']['run_dir'], 'cmd')
default['icinga2']['cache_dir'] = ::File.join(node['icinga2']['var_dir'], 'cache/icinga2')
default['icinga2']['spool_dir'] = ::File.join(node['icinga2']['var_dir'], 'spool/icinga2')
default['icinga2']['perfdata_dir'] = ::File.join(node['icinga2']['var_dir'], 'spool/icinga2/perfdata')
default['icinga2']['lib_dir'] = ::File.join(node['icinga2']['var_dir'], 'lib/icinga2')
default['icinga2']['log_dir'] = ::File.join(node['icinga2']['var_dir'], 'log/icinga2')
default['icinga2']['cache_dir'] = ::File.join(node['icinga2']['var_dir'], 'cache/icinga2')
default['icinga2']['service_name'] = 'icinga2'

case node['platform_family']
when 'rhel'
  default['icinga2']['user'] = 'icinga'
  default['icinga2']['group'] = 'icinga'
  default['icinga2']['cmdgroup'] = 'icingacmd'
  default['icinga2']['service_config_file'] = '/etc/sysconfig/icinga2'

  default['icinga2']['plugins_dir'] = if node['kernel']['machine'] == 'x86_64'
                                        '/usr/lib64/nagios/plugins'
                                      else
                                        '/usr/lib/nagios/plugins'
                                      end

when 'debian'
  default['icinga2']['user'] = 'nagios'
  default['icinga2']['group'] = 'nagios'
  default['icinga2']['cmdgroup'] = 'nagios'
  default['icinga2']['service_config_file'] = '/etc/default/icinga2'
  default['icinga2']['plugins_dir'] = '/usr/lib/nagios/plugins'
when 'windows'
  default['icinga2']['user'] = 'NT AUTHORITY\\NETWORK SERVICE'
  default['icinga2']['group'] = 'NT AUTHORITY\\NETWORK SERVICE'
  default['icinga2']['cmdgroup'] = 'NT AUTHORITY\\NETWORK SERVICE'
  default['icinga2']['plugins_dir'] = 'C:/Program Files/ICINGA2/sbin'
end

default['icinga2']['custom_plugins_dir'] = if node['platform'] == 'windows'
                                             'C:/Program Files/ICINGA2/share/icinga2/include/plugins-custom'
                                           else
                                             '/opt/icinga2_custom_plugins'
                                           end

default['icinga2']['admin_user'] = 'icingaadmin'

default['icinga2']['endpoint_port'] = 5665

# ulimit
default['icinga2']['limits']['memlock']    = 'unlimited'
default['icinga2']['limits']['nofile']     = 48_000
default['icinga2']['limits']['nproc']      = 'unlimited'
