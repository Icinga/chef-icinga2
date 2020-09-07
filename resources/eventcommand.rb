resource_name :icinga2_eventcommand if respond_to?(:resource_name)
provides :icinga2_eventcommand
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'
property :import, String, default: 'plugin-event-command'
property :command, [ String, Array ]
property :env, Hash
property :timeout, [String, Integer]
property :arguments, Hash
property :custom_vars, Hash
property :icinga2_template, [TrueClass, FalseClass], default: false
property :template_support, TrueClass, default: true
property :resource_properties, Array, default: %w(import command env timeout arguments custom_vars template)
