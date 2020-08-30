

def create_hostgroups(env_resources)
  env_hostgroups = []

  # environment hostgroups
  env_hostgroups += env_resources['clusters'] if new_resource.enable_cluster_hostgroup && env_resources.key?('clusters') && env_resources['clusters'].is_a?(Array)

  env_hostgroups += env_resources['applications'] if new_resource.enable_application_hostgroup && env_resources.key?('applications') && env_resources['applications'].is_a?(Array)

  env_hostgroups += env_resources['roles'] if new_resource.enable_role_hostgroup && env_resources.key?('roles') && env_resources['roles'].is_a?(Array)

  env_hostgroups.uniq!

  hostgroup_template = icinga2_envhostgroup new_resource.environment do
    groups env_hostgroups
    zone new_resource.zone
  end

  hostgroup_template.updated?
end

def create_endpoints(env_resources)
  nodes = env_resources['nodes']
  env_endpoints = nodes.map { |n| n[1]['fqdn'] }

  endpoint_template = icinga2_envendpoint new_resource.environment do
    endpoints env_endpoints
    port new_resource.endpoint_port
    log_duration new_resource.endpoint_log_duration
    zone new_resource.zone
  end

  endpoint_template.updated?
end

def create_zones(env_resources)
  nodes = env_resources['nodes']
  env_zones = nodes.map { |n| n[1]['fqdn'] }

  zone_template = icinga2_envzone new_resource.environment do
    zones env_zones
    parent new_resource.zone_parent
    zone new_resource.zone
  end

  zone_template.updated?
end

def create_pki_tickets(env_resources)
  env       = new_resource.environment
  salt      = new_resource.pki_ticket_salt
  nodes     = env_resources['nodes']
  all_fqdns = nodes.map { |n| n[1]['fqdn'] }
  tickets   = {}

  begin
    databag_item = data_bag_item('icinga2', "#{env}-pki-tickets")
    tickets      = databag_item['tickets']

    if tickets['salt'] != salt
      uncreated_tickets_fqdns = all_fqdns
    else
      tickets_fqdns = tickets.map { |k, _v| k }
      uncreated_tickets_fqdns = all_fqdns - tickets_fqdns
    end
  rescue
    uncreated_tickets_fqdns = all_fqdns
  end

  unless uncreated_tickets_fqdns.empty?
    uncreated_tickets_fqdns.each do |f|
      ruby_block "Create PKI-Ticket #{f}" do
        block do
          ticket_bash = Mixlib::ShellOut.new("icinga2 pki ticket --cn #{f} --salt #{salt}")
          ticket_bash.run_command
          tickets[f] = ticket_bash.stdout.chomp
          databag_item = Chef::DataBagItem.new
          databag_item.data_bag('icinga2')
          databag_item.raw_data = {
            'id'      => "#{env}-pki-tickets",
            'tickets' => tickets,
            'salt'    => salt,
          }
          databag_item.save
        end
        action :create
      end
    end
  end
end
