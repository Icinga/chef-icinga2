resource_name :icinga2_timeperiod if respond_to?(:resource_name)
provides :icinga2_timeperiod
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'
property :display_name, String
property :import, String
property :ranges, Hash
property :zone, String

property :template, [TrueClass, FalseClass], default: false
property :template_support, TrueClass, default: true
property :resource_properties, Array, default: %w(display_name ranges zone import template)
