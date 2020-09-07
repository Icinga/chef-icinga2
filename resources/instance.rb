
provides :icinga2_instance if respond_to?(:provides)
property :environment, String, name_property: true
property :template_support, FalseClass, default: false

property :resource_properties, Array

action :create do
  object_template
end

action :delete do
  object_template
end

action_class do
  def object_template
    pp resource_name.inspect
    pp resource_properties.inspect

    process_icinga2_resources(new_resource.resource_name.to_s.gsub('icinga2_', ''), new_resource.resource_properties, new_resource.template_support)
  end
end
