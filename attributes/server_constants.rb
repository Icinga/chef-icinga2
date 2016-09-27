
# frozen_string_literal: true
default['icinga2']['constants']['NodeName'] = node['fqdn']
default['icinga2']['constants']['PluginDir'] = node['icinga2']['plugins_dir']
default['icinga2']['constants']['ManubulonPluginDir'] = node['icinga2']['plugins_dir']
default['icinga2']['constants']['TicketSalt'] = 'ed25aed394c4bf7d236b347bb67df466'
