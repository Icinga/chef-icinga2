# frozen_string_literal: true
# resource
class Chef
  class Resource
    # provides icinga2_environment
    class Icinga2Environment < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :icinga2_environment if respond_to?(:resource_name)
        @provides = :icinga2_environment
        @provider = Chef::Provider::Icinga2Environment
        @action = :create
        @allowed_actions = [:create, :delete, :nothing]
        @name = name
      end

      def environment(arg = nil)
        set_or_return(
          :environment, arg,
          :required => true,
          :kind_of => String,
          :default => nil
        )
      end

      def search_pattern(arg = nil)
        set_or_return(
          :search_pattern, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def env_resources(arg = nil)
        set_or_return(
          :env_resources, arg,
          :kind_of => Hash,
          :default => nil
        )
      end

      def cookbook(arg = nil)
        set_or_return(
          :cookbook, arg,
          :kind_of => String,
          :default => 'icinga2'
        )
      end

      def template(arg = nil)
        set_or_return(
          :template, arg,
          :kind_of => String,
          :default => 'object.environment.conf.erb'
        )
      end

      # create host group for node clusters, applications, roles and recipes
      def enable_cluster_hostgroup(arg = nil)
        set_or_return(
          :enable_cluster_hostgroup, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => node['icinga2']['enable_cluster_hostgroup']
        )
      end

      def cluster_attribute(arg = nil)
        set_or_return(
          :cluster_attribute, arg,
          :kind_of => String,
          :default => node['icinga2']['cluster_attribute']
        )
      end

      def enable_application_hostgroup(arg = nil)
        set_or_return(
          :enable_application_hostgroup, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => node['icinga2']['enable_application_hostgroup']
        )
      end

      def application_attribute(arg = nil)
        set_or_return(
          :application_attribute, arg,
          :kind_of => String,
          :default => node['icinga2']['application_attribute']
        )
      end

      def enable_role_hostgroup(arg = nil)
        set_or_return(
          :enable_role_hostgroup, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => node['icinga2']['enable_role_hostgroup']
        )
      end

      def use_fqdn_resolv(arg = nil)
        set_or_return(
          :use_fqdn_resolv, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => node['icinga2']['use_fqdn_resolv']
        )
      end

      def failover_fqdn_address(arg = nil)
        set_or_return(
          :failover_fqdn_address, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => node['icinga2']['failover_fqdn_address']
        )
      end

      def ignore_node_error(arg = nil)
        set_or_return(
          :ignore_node_error, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => node['icinga2']['ignore_node_error']
        )
      end

      def ignore_resolv_error(arg = nil)
        set_or_return(
          :ignore_resolv_error, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => node['icinga2']['ignore_resolv_error']
        )
      end

      def exclude_recipes(arg = nil)
        set_or_return(
          :exclude_recipes, arg,
          :kind_of => Array,
          :default => []
        )
      end

      def exclude_roles(arg = nil)
        set_or_return(
          :exclude_roles, arg,
          :kind_of => Array,
          :default => []
        )
      end

      def env_custom_vars(arg = nil)
        set_or_return(
          :env_custom_vars, arg,
          :kind_of => Hash,
          :default => {}
        )
      end

      def limit_region(arg = nil)
        set_or_return(
          :limit_region, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => node['icinga2']['limit_region']
        )
      end

      def server_region(arg = nil)
        set_or_return(
          :server_region, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def host_display_name_attr(arg = nil)
        set_or_return(
          :host_display_name_attr, arg,
          :kind_of => String,
          :equal_to => %w(fqdn hostname name),
          :default => node['icinga2']['host_display_name_attr']
        )
      end

      def add_cloud_custom_vars(arg = nil)
        set_or_return(
          :add_cloud_custom_vars, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => node['icinga2']['add_cloud_custom_vars']
        )
      end

      def add_inet_custom_vars(arg = nil)
        set_or_return(
          :add_inet_custom_vars, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => node['icinga2']['add_inet_custom_vars']
        )
      end

      def add_node_vars(arg = nil)
        set_or_return(
          :add_node_vars, arg,
          :kind_of => Hash,
          :default => {}
        )
      end

      def env_filter_node_vars(arg = nil)
        set_or_return(
          :env_filter_node_vars, arg,
          :kind_of => Hash,
          :default => {}
        )
      end

      def env_skip_node_vars(arg = nil)
        set_or_return(
          :env_skip_node_vars, arg,
          :kind_of => Hash,
          :default => {}
        )
      end

      # environment host default attributes
      def import(arg = nil)
        set_or_return(
          :import, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def check_command(arg = nil)
        set_or_return(
          :check_command, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def max_check_attempts(arg = nil)
        set_or_return(
          :max_check_attempts, arg,
          :kind_of => Integer,
          :default => nil
        )
      end

      def check_period(arg = nil)
        set_or_return(
          :check_period, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def check_interval(arg = nil)
        set_or_return(
          :check_interval, arg,
          :regex => /^\d+[smhd]$/,
          :kind_of => [String, Integer],
          :default => nil
        )
      end

      def retry_interval(arg = nil)
        set_or_return(
          :retry_interval, arg,
          :regex => /^\d+[smhd]$/,
          :kind_of => [String, Integer],
          :default => nil
        )
      end

      def enable_notifications(arg = nil)
        set_or_return(
          :enable_notifications, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => nil
        )
      end

      def enable_active_checks(arg = nil)
        set_or_return(
          :enable_active_checks, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => nil
        )
      end

      def enable_passive_checks(arg = nil)
        set_or_return(
          :enable_passive_checks, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => nil
        )
      end

      def enable_event_handler(arg = nil)
        set_or_return(
          :enable_event_handler, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => nil
        )
      end

      def enable_flapping(arg = nil)
        set_or_return(
          :enable_flapping, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => nil
        )
      end

      def enable_perfdata(arg = nil)
        set_or_return(
          :enable_perfdata, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => nil
        )
      end

      def event_command(arg = nil)
        set_or_return(
          :event_command, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def flapping_threshold(arg = nil)
        set_or_return(
          :flapping_threshold, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def volatile(arg = nil)
        set_or_return(
          :volatile, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => nil
        )
      end

      def zone(arg = nil)
        set_or_return(
          :zone, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def command_endpoint(arg = nil)
        set_or_return(
          :command_endpoint, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def notes(arg = nil)
        set_or_return(
          :notes, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def notes_url(arg = nil)
        set_or_return(
          :notes_url, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def action_url(arg = nil)
        set_or_return(
          :action_url, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def icon_image(arg = nil)
        set_or_return(
          :icon_image, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def icon_image_alt(arg = nil)
        set_or_return(
          :icon_image_alt, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def endpoint_port(arg = nil)
        set_or_return(
          :endpoint_port, arg,
          :kind_of => Integer,
          :default => node['icinga2']['endpoint_port']
        )
      end

      def endpoint_log_duration(arg = nil)
        set_or_return(
          :log_duration, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def zone_parent(arg = nil)
        set_or_return(
          :zone_parent, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def pki_ticket_salt(arg = nil)
        set_or_return(
          :pki_ticket_salt, arg,
          :kind_of => String,
          :default => node['icinga2']['constants']['TicketSalt']
        )
      end
    end
  end
end
