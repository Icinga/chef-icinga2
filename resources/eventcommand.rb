resource_name :icinga2_eventcommand
provides :icinga2_eventcommand
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'
property :import, String, default: 'plugin-event-command'
property :command, [ String, Array ]
property :env, Hash
property :timeout, [String, Integer]
property :arguments, Hash
property :custom_vars, Hash
property :template, [true, false], default: false
property :template_support, TrueClass, default: true
property :resource_properties, Array, default: %w(import command env timeout arguments custom_vars template)

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
