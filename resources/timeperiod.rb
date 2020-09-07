resource_name :icinga2_timeperiod
provides :icinga2_timeperiod
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'
property :display_name, String
property :import, String
property :ranges, Hash
property :zone, String

property :icinga2_template, [true, false], default: false
property :template_support, TrueClass, default: true
property :resource_properties, Array, default: %w(display_name ranges zone import template)
