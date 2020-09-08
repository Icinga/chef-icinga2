resource_name :icinga2_scheduleddowntime
provides :icinga2_scheduleddowntime
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'
property :host_name, String
property :service_name, String
property :author, String
property :comment, String
property :fixed, [true, false]
property :duration, String
property :zone, String
property :ranges, Hash

property :template, [true, false], default: false
property :template_support, TrueClass, default: true
property :resource_properties, Array, default: %w(host_name service_name author comment fixed duration zone ranges template)

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
