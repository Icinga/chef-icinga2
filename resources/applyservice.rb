resource_name :icinga2_applyservice
provides :icinga2_applyservice
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'
property :display_name, String
property :import, String
property :host_name, String
property :groups, Array

property :check_command, String

property :max_check_attempts, Integer
property :check_period, String
property :notification_period, String
property :check_interval, [String, Integer]
property :retry_interval, [String, Integer]
property :enable_notifications, [true, false]
property :enable_active_checks, [true, false]
property :enable_passive_checks, [true, false]
property :enable_event_handler, [true, false]
property :enable_flapping, [true, false]
property :enable_perfdata, [true, false]
property :event_command, String
property :flapping_threshold, String
property :volatile, [true, false]
property :zone, String
property :command_endpoint, String
property :notes, String
property :notes_url, String
property :action_url, String
property :icon_image, String
property :icon_image_alt, String
property :merge_vars, Array
property :custom_vars, Hash
property :assign_where, Array
property :ignore_where, Array

property :set, String, regex: [ /^([a-z|_]+\s=>\s)?[a-z|_]+\sin\s\S+$/ ]

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
    process_icinga2_resources(new_resource.resource_name.to_s.gsub('icinga2_', ''), new_resource.resource_properties, new_resource.template_support, object_resources)
  end
end
