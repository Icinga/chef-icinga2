resource_name :icinga2_scheduleddowntime if respond_to?(:resource_name)
provides :icinga2_scheduleddowntime
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'
property :host_name, String
property :service_name, String
property :author, String
property :comment, String
property :fixed, [TrueClass, FalseClass]
property :duration, String
property :zone, String
property :ranges, Hash

property :icinga2_template, [TrueClass, FalseClass], default: false
property :template_support, TrueClass, default: true
property :resource_properties, Array, default: %w(host_name service_name author comment fixed duration zone ranges template)
