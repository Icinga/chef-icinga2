resource_name :icinga2_host if respond_to?(:resource_name)
provides :icinga2_host
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'
property :import, String
property :address, String
property :address6, String
property :groups, Array
property :check_command, String
property :max_check_attempts, Integer
property :check_period, String
property :notification_period, String
property :check_interval, [String, Integer]
property :retry_interval, [String, Integer]
property :enable_notifications, [TrueClass, FalseClass]
property :enable_active_checks, [TrueClass, FalseClass]
property :enable_passive_checks, [TrueClass, FalseClass]
property :enable_event_handler, [TrueClass, FalseClass]
property :enable_flapping, [TrueClass, FalseClass]
property :enable_perfdata, [TrueClass, FalseClass]
property :event_command, String
property :flapping_threshold, String
property :volatile, [TrueClass, FalseClass]
property :zone, String
property :command_endpoint, String
property :notes, String
property :flapping_threshold, String
property :notes_url, String
property :action_url, String
property :icon_image, String
property :icon_image_alt, String
property :custom_vars, Hash

property :template, [TrueClass, FalseClass], default: false
property :template_support, TrueClass, default: true
property :resource_properties, Array, default: %w(import display_name address address6 groups check_command max_check_attempts check_period notification_period check_interval retry_interval enable_notifications enable_active_checks enable_passive_checks enable_event_handler enable_flapping enable_perfdata event_command flapping_threshold volatile zone command_endpoint notes notes_url action_url icon_image icon_image_alt custom_vars template)
