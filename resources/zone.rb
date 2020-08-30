resource_name :icinga2_zone if respond_to?(:resource_name)
provides :icinga2_zone
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'
property :endpoints, Array
property :parent, String
property :global, [TrueClass, FalseClass]

property :template_support, FalseClass, default: false
property :resource_properties, Array, default: %w(endpoints parent global)
