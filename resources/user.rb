resource_name :icinga2_user if respond_to?(:resource_name)
provides :icinga2_user
# enclosing_provider Chef::Provider::Icinga2Instance
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'
property :import, String
property :display_name, String
property :groups, Array
property :email, String
property :pager, String
property :period, String
property :states, Array
property :types, Array
property :zone, String
property :custom_vars, Hash
property :enable_notifications, [TrueClass, FalseClass]
property :icinga2_template, [TrueClass, FalseClass], default: false
property :template_support, TrueClass, default: true
property :resource_properties, Array, default: %w(import display_name groups email pager period states types zone custom_vars enable_notifications template)
