resource_name :icinga2_hostgroup
provides :icinga2_hostgroup
allowed_actions [:create, :delete, :nothing]
property :cookbook, String, default: 'icinga2'

property :display_name, String
property :groups, Array
property :zone, String
property :assign_where, Array
property :ignore_where, Array

property :template_support, FalseClass, default: false
property :resource_properties, Array, default: %w(display_name groups zone assign_where ignore_where)
