resource_name :icinga2_notification if respond_to?(:resource_name)
provides :icinga2_notification
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'
property :import, String
property :host_name, String
property :service_name, String
property :users, Array
property :user_groups, Array
property :command, String
property :times, Hash
property :interval, [String, Integer], regex: [/^\d+[smhd]$/]
property :period, String
property :zone, String
property :types, Array
property :states, Array
property :custom_vars, Hash

property :icinga2_template, [TrueClass, FalseClass], default: false
property :template_support, TrueClass, default: true
property :resource_properties, Array, default: %w(import host_name service_name users user_groups times command interval period zone types states custom_vars template)
