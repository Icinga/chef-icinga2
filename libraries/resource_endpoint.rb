# frozen_string_literal: true
class Chef
  class Resource
    # provides icinga2_endpoint
    class Icinga2Endpoint < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :icinga2_endpoint if respond_to?(:resource_name)
        @provides = :icinga2_endpoint
        @provider = Chef::Provider::Icinga2Instance
        @action = :create
        @allowed_actions = [:create, :delete, :nothing]
        @name = name
      end

      def cookbook(arg = nil)
        set_or_return(
          :cookbook, arg,
          :kind_of => String,
          :default => 'icinga2'
        )
      end

      def host(arg = nil)
        set_or_return(
          :host, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def port(arg = nil)
        set_or_return(
          :port, arg,
          :kind_of => Integer,
          :default => node['icinga2']['endpoint_port']
        )
      end

      def log_duration(arg = nil)
        set_or_return(
          :log_duration, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def template_support(arg = nil)
        set_or_return(
          :template_support, arg,
          :kind_of => [FalseClass],
          :default => false
        )
      end

      def resource_properties(arg = nil)
        set_or_return(
          :resource_properties, arg,
          :kind_of => Array,
          :default => %w(host port log_duration)
        )
      end
    end
  end
end
