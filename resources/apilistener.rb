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

action :create do
  object_template
end

action :delete do
  object_template
end

action_class do
  include Icinga2::Cookbook::Instances
  def object_template
    object_resources = []
    object_resources << @new_resource
    process_icinga2_resources(new_resource.resource_name.to_s.gsub('icinga2_', ''), new_resource.resource_properties, new_resource.template_support)
  end
end
