include Icinga2::Cookbook::Instances
unified_mode true

resource_name :icinga2_timeperiod
provides :icinga2_timeperiod

property :cookbook, String, default: 'icinga2'
property :display_name, String
property :import, String
property :ranges, Hash
property :zone, String

property :template, [true, false], default: false
property :template_support, TrueClass, default: true
property :resource_properties, Array, default: %w(display_name ranges zone import template)

action :create do
  object_template
end

action :delete do
  object_template
end

action_class do
  include Icinga2::Cookbook::Instances
  def object_template
    process_icinga2_resources(new_resource.resource_name.to_s.gsub('icinga2_', ''), new_resource.resource_properties, new_resource.template_support)
  end
end
