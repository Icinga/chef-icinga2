resource_name :icinga2_endpoint if respond_to?(:resource_name)
provides :icinga2_endpoint
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'
property :host, String
property :port, Integer, default: node['icinga2']['endpoint_port']
property :log_duration, String
property :template_support, FalseClass, default: false
property :resource_properties, Array, default: %w(host port log_duration)
