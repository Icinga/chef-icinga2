# frozen_string_literal: true
['icinga2']['recreate_server_certs'] = false

pki_dir       = '/etc/icinga2/pki'
client_key    = "#{pki_dir}/#{node.fqdn}.key"
client_crt    = "#{pki_dir}/#{node.fqdn}.crt"
client_csr    = "#{pki_dir}/#{node.fqdn}.csr"

if node['icinga2']['recreate_server_certs']
  [
    '/var/lib/icinga2/ca/ca.key',
    '/var/lib/icinga2/ca/ca.crt',
    client_key,
    client_crt,
    client_csr
  ].each do |file|
    file file do
      action :delete
    end
  end
end

bash 'Generate self signed ca' do
  code 'icinga2 pki new-ca'
  not_if { ::File.exist?('/var/lib/icinga2/ca/ca.key') }
end

bash 'Generate self signed crt/key' do
  code "icinga2 pki new-cert --cn #{node.fqdn} " \
       "--key #{client_key} " \
       "--csr #{client_csr}"
  not_if { ::File.exist?(client_csr) }
end

bash 'Signed self signed crt/key' do
  code 'icinga2 pki sign-csr ' \
       "--csr #{client_csr} " \
       "--cert #{client_crt}"
  not_if { ::File.exist?(client_crt) }
end

icinga2_apilistener 'master' do
  cert_path "\"#{client_crt}\""
  key_path "\"#{client_key}\""
  ca_path '"/var/lib/icinga2/ca/ca.crt"'
  ticket_salt 'TicketSalt'
end

icinga2_endpoint node.fqdn do
  host node.fqdn
end

icinga2_zone 'master' do
  endpoints [node.fqdn]
end
