# frozen_string_literal: true
['icinga2']['recreate_client_certs'] = false

include_recipe 'icinga2::client'

pki_dir       = '/etc/icinga2/pki'
client_key    = "#{pki_dir}/#{node.fqdn}.key"
client_crt    = "#{pki_dir}/#{node.fqdn}.crt"
master_ca     = "#{pki_dir}/ca.crt"
master_crt    = "#{pki_dir}/trusted-master.crt"
server_host   = node['icinga2']['server']['ip']

if node['icinga2']['recreate_client_certs']
  [
    '/etc/icinga2/pki/ca.crt',
    '/etc/icinga2/pki/trusted-master.crt',
    "/etc/icinga2/pki/#{node.fqdn}.key",
    "/etc/icinga2/pki/#{node.fqdn}.crt"
  ].each do |file|
    file file do
      action :delete
    end
  end
end

bash 'Generate self signed crt/key' do
  code "icinga2 pki new-cert --cn #{node.fqdn} " \
       "--key #{client_key} " \
       "--cert #{client_crt}"
  not_if { ::File.exist?(client_key) }
end

begin
  pki_item    = "#{node.chef_environment}-pki-tickets"
  pki_tickets = data_bag_item('icinga2', pki_item)
  ticket      = pki_tickets['tickets'][node.fqdn]
rescue
  Chef::Application.fatal!("FQDN #{node.fqdn} not found in #{pki_item} Item in icinga2 databag.")
end

bash 'Request master certificate' do
  code "icinga2 pki save-cert --key #{client_key} " \
       "--cert #{client_crt} " \
       "--trustedcert #{master_crt} " \
       "--host #{server_host} || " \
       "(echo 'Icinga2 Server not running';exit 1)"
  not_if { ::File.exist?(master_crt) }
  notifies :reload, 'service[icinga2]', :delayed
end

bash 'Request master ca' do
  code "icinga2 pki request --host #{server_host} " \
       '--port 5665 ' \
       "--ticket #{ticket} " \
       "--key #{client_key} " \
       "--cert #{client_crt} " \
       "--trustedcert #{master_crt} " \
       "--ca #{master_ca} || " \
       "(echo 'Icinga2 Server not running';exit 1)"
  not_if { ::File.exist?(master_ca) }
  notifies :reload, 'service[icinga2]', :delayed
end

icinga2_endpoint node['icinga2']['server']['fqdn'] do
  host node['icinga2']['server']['ip']
  port 5665
end

icinga2_zone 'master' do
  endpoints [node['icinga2']['server']['fqdn']]
end

icinga2_endpoint node.fqdn do
  host node.fqdn
end

icinga2_zone node.fqdn do
  endpoints [node.fqdn]
  parent 'master'
end

icinga2_apilistener node.fqdn do
  cert_path "\"#{client_crt}\""
  key_path "\"#{client_key}\""
  ca_path "\"#{master_ca}\""
  bind_port 5665
  accept_commands true
end
