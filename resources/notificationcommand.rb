resource_name :icinga2_notificationcommand
provides :icinga2_notificationcommand
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'
property :display_name, String
property :import, String, default: 'plugin-notification-command'
property :host_name, String
property :groups, Array
property :command, [String, Array]
property :env, Hash
property :timeout, Integer
property :zone, String
property :arguments, Hash
property :custom_vars, Hash

property :template, [true, false], default: false
property :template_support, TrueClass, default: true
property :resource_properties, Array, default: %w(import command env timeout zone arguments custom_vars template)

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
