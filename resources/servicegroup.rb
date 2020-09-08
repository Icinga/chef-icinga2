resource_name :icinga2_servicegroup
provides :icinga2_servicegroup
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'
property :display_name, String
property :groups, Array
property :zone, String
property :assign_where, Array
property :ignore_where, Array

property :template_support, FalseClass, default: false
property :resource_properties, Array, default: %w(display_name groups zone assign_where ignore_where)

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
