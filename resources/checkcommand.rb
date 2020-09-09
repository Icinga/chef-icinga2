resource_name :icinga2_checkcommand
provides :icinga2_checkcommand
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'
property :display_name, String
property :import, String, default: 'plugin-check-command'
property :command, [String, Array]
property :env, Hash
property :timeout, Integer
property :zone, String
property :arguments, Hash
property :custom_vars, Hash

property :template, [true, false], default: false
property :template_support, FalseClass, default: false
property :resource_properties, Array, default: %w(import display_name host_name groups check_command max_check_attempts check_period notification_period check_interval retry_interval enable_notifications enable_active_checks enable_passive_checks enable_event_handler enable_flapping enable_perfdata event_command flapping_threshold volatile zone command_endpoint notes notes_url action_url icon_image icon_image_alt merge_vars custom_vars assign_where ignore_where set)

action :create do
  object_template
end

action :delete do
  object_template
end

action_class do
  include Icinga2::Cookbook::Instances
  def object_template
    object_resources = []
    object_resources << @new_resource
    process_icinga2_resources(new_resource.resource_name.to_s.gsub('icinga2_', ''), new_resource.resource_properties, new_resource.template_support)
  end
end
