# frozen_string_literal: true
class Chef
  class Resource
    # provides icinga2_apilistener
    class Icinga2Apilistener < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :icinga2_apilistener if respond_to?(:resource_name)
        @provides = :icinga2_apilistener
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

      def cert_path(arg = nil)
        set_or_return(
          :cert_path, arg,
          :kind_of => String,
          :required => true,
          :default => nil
        )
      end

      def key_path(arg = nil)
        set_or_return(
          :key_path, arg,
          :kind_of => String,
          :required => true,
          :default => nil
        )
      end

      def ca_path(arg = nil)
        set_or_return(
          :ca_path, arg,
          :kind_of => String,
          :required => true,
          :default => nil
        )
      end

      def crl_path(arg = nil)
        set_or_return(
          :crl_path, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def bind_host(arg = nil)
        set_or_return(
          :bind_host, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def bind_port(arg = nil)
        set_or_return(
          :bind_port, arg,
          :kind_of => Integer,
          :default => nil
        )
      end

      def ticket_salt(arg = nil)
        set_or_return(
          :ticket_salt, arg,
          :kind_of => String,
          :default => 'TicketSalt'
        )
      end

      def accept_config(arg = nil)
        set_or_return(
          :accept_config, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => nil
        )
      end

      def accept_commands(arg = nil)
        set_or_return(
          :accept_commands, arg,
          :kind_of => [TrueClass, FalseClass],
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
          :default => %w(cert_path key_path ca_path crl_path bind_host bind_port ticket_salt accept_config accept_commands)
        )
      end
    end
  end
end
