# frozen_string_literal: true
#
# Cookbook Name:: icinga2
# Provider:: environment
#
# Copyright 2014, Virender Khatri
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# provider
class Chef
  class Provider
    # provides icinga2_environment
    class Icinga2Environment < Chef::Provider::LWRPBase
      provides :icinga2_environment if respond_to?(:provides)

      def whyrun_supported?
        true
      end

      action :create do
        object_template
      end

      action :delete do
        object_template
      end

      protected

      def object_template
        search_pattern = new_resource.search_pattern || "chef_environment:#{new_resource.environment}"
        server_region = new_resource.server_region

        if new_resource.limit_region && !server_region
          server_region = node['ec2']['placement_availability_zone'].chop if node.key?('ec2')
        end
        env_resources = new_resource.env_resources || Icinga2::Search.new(:environment => new_resource.environment,
                                                                          :enable_cluster_hostgroup => new_resource.enable_cluster_hostgroup,
                                                                          :cluster_attribute => new_resource.cluster_attribute,
                                                                          :enable_application_hostgroup => new_resource.enable_application_hostgroup,
                                                                          :application_attribute => new_resource.application_attribute,
                                                                          :enable_role_hostgroup => new_resource.enable_role_hostgroup,
                                                                          :ignore_node_error => new_resource.ignore_node_error,
                                                                          :use_fqdn_resolv => new_resource.use_fqdn_resolv,
                                                                          :failover_fqdn_address => new_resource.failover_fqdn_address,
                                                                          :ignore_resolv_error => new_resource.ignore_resolv_error,
                                                                          :exclude_recipes => new_resource.exclude_recipes,
                                                                          :exclude_roles => new_resource.exclude_roles,
                                                                          :env_custom_vars => new_resource.env_custom_vars,
                                                                          :env_skip_node_vars => new_resource.env_skip_node_vars,
                                                                          :env_filter_node_vars => new_resource.env_filter_node_vars,
                                                                          :limit_region => new_resource.limit_region,
                                                                          :server_region => server_region,
                                                                          :search_pattern => search_pattern,
                                                                          :add_node_vars => new_resource.add_node_vars,
                                                                          :add_inet_custom_vars => new_resource.add_inet_custom_vars,
                                                                          :add_cloud_custom_vars => new_resource.add_cloud_custom_vars).environment_resources

        template_file_name = new_resource.zone ? "host_#{new_resource.environment}_#{new_resource.zone}_#{new_resource.name}.conf" : "host_#{new_resource.environment}_#{new_resource.name}.conf"
        env_hosts = {}
        env_hosts = env_resources['nodes'] if env_resources.key?('nodes') && env_resources['nodes'].is_a?(Hash)

        if new_resource.zone
          env_resources_path = ::File.join(node['icinga2']['zones_dir'], new_resource.zone, template_file_name)

          directory ::File.join(node['icinga2']['zones_dir'], new_resource.zone) do
            owner node['icinga2']['user']
            group node['icinga2']['group']
            action :create
            only_if { !env_hosts.empty? }
          end
        else
          env_resources_path = ::File.join(node['icinga2']['objects_dir'], template_file_name)
        end
        hosts_template = template env_resources_path do
          source new_resource.template
          cookbook new_resource.cookbook
          owner node['icinga2']['user']
          group node['icinga2']['group']
          mode 0o640
          variables(:environment => new_resource.environment,
                    :hosts => env_hosts,
                    :host_display_name_attr => new_resource.host_display_name_attr,
                    :import => new_resource.import,
                    :check_command => new_resource.check_command,
                    :max_check_attempts => new_resource.max_check_attempts,
                    :check_period => new_resource.check_period,
                    :notification_period => new_resource.notification_period,
                    :check_interval => new_resource.check_interval,
                    :retry_interval => new_resource.retry_interval,
                    :enable_notifications => new_resource.enable_notifications,
                    :enable_active_checks => new_resource.enable_active_checks,
                    :enable_passive_checks => new_resource.enable_passive_checks,
                    :enable_event_handler => new_resource.enable_event_handler,
                    :enable_flapping => new_resource.enable_flapping,
                    :enable_perfdata => new_resource.enable_perfdata,
                    :event_command => new_resource.event_command,
                    :flapping_threshold => new_resource.flapping_threshold,
                    :volatile => new_resource.volatile,
                    :command_endpoint => new_resource.command_endpoint,
                    :notes => new_resource.notes,
                    :notes_url => new_resource.notes_url,
                    :action_url => new_resource.action_url,
                    :icon_image => new_resource.icon_image,
                    :icon_image_alt => new_resource.icon_image_alt)
          notifies platform?('windows') ? :restart : :reload, 'service[icinga2]'
        end
        return true if hosts_template.updated? || create_hostgroups(env_resources)
        if node['icinga2']['enable_env_pki']
          return true if hosts_template.updated? || create_endpoints(env_resources)
          return true if hosts_template.updated? || create_zones(env_resources)
          unless node['icinga2']['enable_env_custom_pki']
            return true if hosts_template.updated? || create_pki_tickets(env_resources)
          end
        end
      end

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
    end
  end
end
