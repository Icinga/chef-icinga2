# https://wiki.icinga.org/display/howtos/Setting+up+Icinga+Classic+UI+Standalone

default['icinga2']['classic_ui']['enable'] = true
# in favour of existing users for rhel
default['icinga2']['classic_ui']['apache_conf'] = value_for_platform(
  %w(centos redhat fedora amazon) => { 'default' => 'icinga2-classic-ui' },
  %w(debian ubuntu) => { 'default' => 'icinga2-classicui' }
)

default['icinga2']['classic_ui']['version'] = '2.4.1-1'

default['icinga2']['classic_ui']['gui_version'] = '1.13.3-0'
default['icinga2']['classic_ui']['web_root'] = value_for_platform(
  %w(centos redhat fedora amazon) => { 'default' => '/usr/share/icinga' },
  %w(debian ubuntu) => { 'default' => '/usr/share/icinga2/classicui' }
)

default['icinga2']['classic_ui']['home_dir'] = value_for_platform(
  %w(debian ubuntu) => { 'default' => '/etc/icinga2-classicui' },
  'default' => '/etc/icinga'
)
default['icinga2']['classic_ui']['conf_dir'] = node['icinga2']['classic_ui']['home_dir']
default['icinga2']['classic_ui']['log_dir'] = '/var/log/icinga'
default['icinga2']['classic_ui']['cgi_log_dir'] = ::File.join(node['icinga2']['classic_ui']['log_dir'], 'gui')

# class ui gui users list
default['icinga2']['classic_ui']['users'] = { 'icingaadmin' => '$apr1$MZtKRLAy$AV9OiJ.V/mI9g30bHn9ol1' }

# classis ui gui users permissions
default['icinga2']['classic_ui']['authorized_for_system_information'] = [node['icinga2']['admin_user']]
default['icinga2']['classic_ui']['authorized_for_configuration_information'] = [node['icinga2']['admin_user']]
default['icinga2']['classic_ui']['authorized_for_full_command_resolution'] = [node['icinga2']['admin_user']]
default['icinga2']['classic_ui']['authorized_for_system_commands'] = [node['icinga2']['admin_user']]
default['icinga2']['classic_ui']['authorized_for_all_services'] = [node['icinga2']['admin_user']]
default['icinga2']['classic_ui']['authorized_for_all_hosts'] = [node['icinga2']['admin_user']]
default['icinga2']['classic_ui']['authorized_for_all_service_commands'] = [node['icinga2']['admin_user']]
default['icinga2']['classic_ui']['authorized_for_all_host_commands'] = [node['icinga2']['admin_user']]

default['icinga2']['classic_ui']['cgi']['standalone_installation'] = 1
default['icinga2']['classic_ui']['cgi']['physical_html_path'] = value_for_platform(
  %w(centos redhat fedora amazon) => { 'default' => '/usr/share/icinga' },
  %w(debian ubuntu) => { 'default' => '/usr/lib/cgi-bin/icinga2-classicui' }
)

default['icinga2']['classic_ui']['cgi']['url_html_path'] = value_for_platform(
  %w(centos redhat fedora amazon) => { 'default' => '/icinga' },
  %w(debian ubuntu) => { 'default' => '/icinga2-classicui' }
)

default['icinga2']['classic_ui']['cgi']['url_stylesheets_path'] = "#{node['icinga2']['classic_ui']['cgi']['url_html_path']}/stylesheets"
default['icinga2']['classic_ui']['cgi']['http_charset'] = 'utf-8'
default['icinga2']['classic_ui']['cgi']['refresh_rate'] = 60
default['icinga2']['classic_ui']['cgi']['refresh_type'] = 1
default['icinga2']['classic_ui']['cgi']['escape_html_tags'] = 1
default['icinga2']['classic_ui']['cgi']['result_limit'] = 50
default['icinga2']['classic_ui']['cgi']['show_tac_header'] = 1
default['icinga2']['classic_ui']['cgi']['use_pending_states'] = 1
default['icinga2']['classic_ui']['cgi']['first_day_of_week'] = 0
default['icinga2']['classic_ui']['cgi']['suppress_maintenance_downtime'] = 0
default['icinga2']['classic_ui']['cgi']['action_url_target'] = 'main'
default['icinga2']['classic_ui']['cgi']['notes_url_target'] = 'main'
default['icinga2']['classic_ui']['cgi']['use_authentication'] = 1
default['icinga2']['classic_ui']['cgi']['use_ssl_authentication'] = 0
default['icinga2']['classic_ui']['cgi']['lowercase_user_name'] = 0
default['icinga2']['classic_ui']['cgi']['show_all_services_host_is_authorized_for'] = 1
default['icinga2']['classic_ui']['cgi']['show_partial_hostgroups'] = 0
default['icinga2']['classic_ui']['cgi']['show_partial_servicegroups'] = 0
default['icinga2']['classic_ui']['cgi']['default_statusmap_layout'] = 5
default['icinga2']['classic_ui']['cgi']['status_show_long_plugin_output'] = 0
default['icinga2']['classic_ui']['cgi']['display_status_totals'] = 0
default['icinga2']['classic_ui']['cgi']['highlight_table_rows'] = 1
default['icinga2']['classic_ui']['cgi']['add_notif_num_hard'] = 28
default['icinga2']['classic_ui']['cgi']['add_notif_num_soft'] = 0
default['icinga2']['classic_ui']['cgi']['use_logging'] = 0
default['icinga2']['classic_ui']['cgi']['cgi_log_file'] = ::File.join(node['icinga2']['classic_ui']['cgi_log_dir'], 'icinga-cgi.log')
default['icinga2']['classic_ui']['cgi']['cgi_log_rotation_method'] = 'd'
default['icinga2']['classic_ui']['cgi']['cgi_log_archive_path'] = node['icinga2']['classic_ui']['cgi_log_dir']
default['icinga2']['classic_ui']['cgi']['enforce_comments_on_actions'] = 0
default['icinga2']['classic_ui']['cgi']['send_ack_notifications'] = 1
default['icinga2']['classic_ui']['cgi']['persistent_ack_comments'] = 0
default['icinga2']['classic_ui']['cgi']['lock_author_names'] = 1
default['icinga2']['classic_ui']['cgi']['default_downtime_duration'] = 7200
default['icinga2']['classic_ui']['cgi']['set_expire_ack_by_default'] = 0
default['icinga2']['classic_ui']['cgi']['default_expiring_acknowledgement_duration'] = 86_400
default['icinga2']['classic_ui']['cgi']['default_expiring_disabled_notifications_duration'] = 86_400
default['icinga2']['classic_ui']['cgi']['tac_show_only_hard_state'] = 0
default['icinga2']['classic_ui']['cgi']['show_tac_header_pending'] = 1
default['icinga2']['classic_ui']['cgi']['exclude_customvar_name'] = 'PASSWORD,COMMUNITY'
default['icinga2']['classic_ui']['cgi']['exclude_customvar_value'] = 'secret'
default['icinga2']['classic_ui']['cgi']['extinfo_show_child_hosts'] = 0
default['icinga2']['classic_ui']['cgi']['tab_friendly_titles'] = 1
######################################
#    STANDALONE (ICINGA 2) OPTIONS'
#    requires standalone_installation
######################################
default['icinga2']['classic_ui']['cgi']['object_cache_file'] = ::File.join(node['icinga2']['cache_dir'], 'objects.cache') # '/var/cache/icinga2/objects.cache'
default['icinga2']['classic_ui']['cgi']['status_file'] = ::File.join(node['icinga2']['cache_dir'], 'status.dat')
default['icinga2']['classic_ui']['cgi']['resource_file'] = ::File.join(node['icinga2']['classic_ui']['conf_dir'], 'resource.cfg')
default['icinga2']['classic_ui']['cgi']['command_file'] = ::File.join(node['icinga2']['run_dir'], 'cmd', 'icinga2.cmd')
default['icinga2']['classic_ui']['cgi']['check_external_commands'] = 1
default['icinga2']['classic_ui']['cgi']['interval_length'] = 60
default['icinga2']['classic_ui']['cgi']['status_update_interval'] = 10
default['icinga2']['classic_ui']['cgi']['log_file'] = ::File.join(node['icinga2']['log_dir'], 'compat', 'icinga.log')
default['icinga2']['classic_ui']['cgi']['log_rotation_method'] = 'h'
default['icinga2']['classic_ui']['cgi']['log_archive_path'] = ::File.join(node['icinga2']['log_dir'], 'compat', 'archives')
default['icinga2']['classic_ui']['cgi']['date_format'] = 'us'
default['icinga2']['classic_ui']['cgi']['url_cgi_path'] = value_for_platform(
  %w(centos redhat fedora amazon) => { 'default' => nil },
  %w(debian ubuntu) => { 'default' => "/cgi-bin#{node['icinga2']['classic_ui']['cgi']['url_html_path']}" }
)
