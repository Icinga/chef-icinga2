resource_name :icinga2_applydependency
provides :icinga2_applydependency
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'
property :object_relation, String, default: 'to'
property :object_type, String, required: true
property :parent_host_name, String
property :child_host_name, String
property :child_service_name, String
property :disable_checks, [true, false]
property :disable_notifications, [true, false]
property :period, String
property :states, Array
property :zone, String
property :assign_where, Array
property :ignore_where, Array
property :template_support, FalseClass, default: false
property :resource_properties, Array, default: %w(object_relation object_type parent_host_name child_host_name parent_service_name child_service_name disable_checks disable_notifications period states zone assign_where ignore_where)
