resource_name :icinga2_zone
provides :icinga2_zone
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'
property :endpoints, Array
property :parent, String
property :global, [true, false]

property :template_support, FalseClass, default: false
property :resource_properties, Array, default: %w(endpoints parent global)
