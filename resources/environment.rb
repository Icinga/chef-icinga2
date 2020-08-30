resource_name :icinga2_environment if respond_to?(:resource_name)
provides :icinga2_environment
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'

property :environment, String
property :search_pattern, String

property :env_resources, Hash
property :enable_cluster_hostgroup, [TrueClass, FalseClass], default: node['icinga2']['enable_cluster_hostgroup']
property :cluster_attribute, String, default: node['icinga2']['cluster_attribute']
property :enable_application_hostgroup, [TrueClass, FalseClass], default: node['icinga2']['enable_application_hostgroup']
property :application_attribute, String, default: node['icinga2']['application_attribute']
property :enable_role_hostgroup, [TrueClass, FalseClass], default: node['icinga2']['enable_role_hostgroup']
property :use_fqdn_resolv, [TrueClass, FalseClass], default: node['icinga2']['use_fqdn_resolv']
property :failover_fqdn_address, [TrueClass, FalseClass], default: node['icinga2']['failover_fqdn_address']
property :ignore_node_error, [TrueClass, FalseClass], default: node['icinga2']['ignore_node_error']
property :ignore_resolv_error, [TrueClass, FalseClass], default: node['icinga2']['ignore_resolv_error']
property :exclude_recipes, Array
property :exclude_roles, Array
property :env_custom_vars, Hash
property :limit_region, [TrueClass, FalseClass], default: node['icinga2']['limit_region']
property :server_region, String
property :host_display_name_attr, String, equal_to: %w(fqdn hostname name), default: node['icinga2']['host_display_name_attr']
property :add_cloud_custom_vars, [TrueClass, FalseClass], default: node['icinga2']['add_cloud_custom_vars']
property :add_inet_custom_vars, [TrueClass, FalseClass], default: node['icinga2']['add_inet_custom_vars']
property :add_node_vars, Hash
property :env_filter_node_vars, Hash
property :env_skip_node_vars, Hash
property :import, String
property :check_command, String
property :max_check_attempts, Integer
property :notification_period, String
property :check_interval, [String, Integer], regex: [/^\d+[smhd]$/]
property :retry_interval, [String, Integer], regex: [/^\d+[smhd]$/]
property :enable_notifications, [TrueClass, FalseClass]
property :enable_active_checks, [TrueClass, FalseClass]
property :enable_passive_checks, [TrueClass, FalseClass]
property :enable_event_handler, [TrueClass, FalseClass]
property :enable_flapping, [TrueClass, FalseClass]
property :enable_perfdata, [TrueClass, FalseClass]
property :event_command, String
property :flapping_threshold, String
property :volatile, [TrueClass, FalseClass]
property :zone, String
property :command_endpoint, String
property :notes, String
property :notes_url, String
property :action_url, String
property :icon_image, String
property :icon_image_alt, String
property :endpoint_port, Integer, default: node['icinga2']['endpoint_port']
property :endpoint_log_duration, String
property :zone_parent, String
property :pki_ticket_salt, String, default: node['icinga2']['constants']['TicketSalt']

property :template, String, default: 'object.environment.conf.erb'
property :template_support, FalseClass, default: false
property :resource_properties, Array, default: %w(import display_name host_name groups check_command max_check_attempts check_period notification_period check_interval retry_interval enable_notifications enable_active_checks enable_passive_checks enable_event_handler enable_flapping enable_perfdata event_command flapping_threshold volatile zone command_endpoint notes notes_url action_url icon_image icon_image_alt merge_vars custom_vars assign_where ignore_where set)

provides :icinga2_environment if respond_to?(:provides)

def whyrun_supported?
  true
end

action :create do
  object_template
end

action :delete do
  object_template
end

def object_template
  search_pattern = new_resource.search_pattern || "chef_environment:#{new_resource.environment}"
  server_region = new_resource.server_region

  if new_resource.limit_region && !server_region
    server_region = node['ec2']['placement_availability_zone'].chop if node.key?('ec2')
  end
  env_resources = new_resource.env_resources || Icinga2::Search.new(environment: new_resource.environment,
                                                                    enable_cluster_hostgroup: new_resource.enable_cluster_hostgroup,
                                                                    cluster_attribute: new_resource.cluster_attribute,
                                                                    enable_application_hostgroup: new_resource.enable_application_hostgroup,
                                                                    application_attribute: new_resource.application_attribute,
                                                                    enable_role_hostgroup: new_resource.enable_role_hostgroup,
                                                                    ignore_node_error: new_resource.ignore_node_error,
                                                                    use_fqdn_resolv: new_resource.use_fqdn_resolv,
                                                                    failover_fqdn_address: new_resource.failover_fqdn_address,
                                                                    ignore_resolv_error: new_resource.ignore_resolv_error,
                                                                    exclude_recipes: new_resource.exclude_recipes,
                                                                    xclude_roles: new_resource.exclude_roles,
                                                                    env_custom_vars: new_resource.env_custom_vars,
                                                                    env_skip_node_vars: new_resource.env_skip_node_vars,
                                                                    env_filter_node_vars: new_resource.env_filter_node_vars,
                                                                    limit_region: new_resource.limit_region,
                                                                    server_region: server_region,
                                                                    search_pattern: search_pattern,
                                                                    add_node_vars: new_resource.add_node_vars,
                                                                    add_inet_custom_vars: new_resource.add_inet_custom_vars,
                                                                    add_cloud_custom_vars: new_resource.add_cloud_custom_vars).environment_resources

  template_file_name = new_resource.zone ? "host_#{new_resource.environment}_#{new_resource.zone}_#{new_resource.name}.conf" : "host_#{new_resource.environment}_#{new_resource.name}.conf"
  env_hosts = {}
  env_hosts = env_resources['nodes'] if env_resources.key?('nodes') && env_resources['nodes'].is_a?(Hash)

  if new_resource.zone
    env_resources_path = ::File.join(node['icinga2']['zones_dir'], new_resource.zone, template_file_name)

    directory ::File.join(node['icinga2']['zones_dir'], new_resource.zone) do
      owner node['icinga2']['user']
      group node['icinga2']['group']
      action :create
      only_if { !env_hosts.empty? }
    end
  else
    env_resources_path = ::File.join(node['icinga2']['objects_dir'], template_file_name)
  end
  hosts_template = template env_resources_path do
    source new_resource.template
    cookbook new_resource.cookbook
    owner node['icinga2']['user']
    group node['icinga2']['group']
    mode 0o640
    variables(environment: new_resource.environment,
              hosts: env_hosts,
              host_display_name_attr: new_resource.host_display_name_attr,
              import: new_resource.import,
              check_command: new_resource.check_command,
              max_check_attempts: new_resource.max_check_attempts,
              check_period: new_resource.check_period,
              notification_period: new_resource.notification_period,
              check_interval: new_resource.check_interval,
              retry_interval: new_resource.retry_interval,
              enable_notifications: new_resource.enable_notifications,
              enable_active_checks: new_resource.enable_active_checks,
              enable_passive_checks: new_resource.enable_passive_checks,
              enable_event_handler: new_resource.enable_event_handler,
              enable_flapping: new_resource.enable_flapping,
              enable_perfdata: new_resource.enable_perfdata,
              event_command: new_resource.event_command,
              flapping_threshold: new_resource.flapping_threshold,
              volatile: new_resource.volatile,
              command_endpoint: new_resource.command_endpoint,
              notes: new_resource.notes,
              notes_url: new_resource.notes_url,
              action_url: new_resource.action_url,
              icon_image: new_resource.icon_image,
              icon_image_alt: new_resource.icon_image_alt)
    notifies platform?('windows') ? :restart : :reload, 'service[icinga2]'
  end
  return true if hosts_template.updated? || create_hostgroups(env_resources)
  if node['icinga2']['enable_env_pki']
    return true if hosts_template.updated? || create_endpoints(env_resources)
    return true if hosts_template.updated? || create_zones(env_resources)
    unless node['icinga2']['enable_env_custom_pki']
      return true if hosts_template.updated? || create_pki_tickets(env_resources)
    end
  end
end
