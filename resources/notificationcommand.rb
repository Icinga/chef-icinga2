resource_name :icinga2_notificationcommand if respond_to?(:resource_name)
provides :icinga2_notificationcommand
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'
property :display_name, String
property :import, String, default: 'plugin-notification-command'
property :host_name, String
property :groups, Array
property :command, [String, Array]
property :env, Hash
property :timeout, Integer
property :zone, String
property :arguments, Hash
property :custom_vars, Hash

property :template, [TrueClass, FalseClass], default: false
property :template_support, TrueClass, default: true
property :resource_properties, Array, default: %w(import command env timeout zone arguments custom_vars template)
