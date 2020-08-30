resource_name :icinga2_apiuser if respond_to?(:resource_name)
provides :icinga2_apiuser
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'
property :password, String, required: true
property :permissions, String, required: true
property :client_cn, String

property :template_support, FalseClass, default: false
property :resource_properties, Array, default: %w(password permissions client_cn)
