resource_name :icinga2_apilistener
provides :icinga2_apilistener
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'
property :cert_path, String, required: true

property :key_path, String, required: true
property :ca_path, String, required: true
property :crl_path, String
property :bind_host, String
property :bind_port, Integer
property :ticket_salt, String, default: 'TicketSalt'
property :accept_config, [true, false]
property :accept_commands, [true, false]

property :template_support, FalseClass, default: false
property :resource_properties, Array, default: %w(cert_path key_path ca_path crl_path bind_host bind_port ticket_salt accept_config accept_commands)
