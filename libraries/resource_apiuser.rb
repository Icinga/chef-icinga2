# frozen_string_literal: true
class Chef
  class Resource
    # provides icinga2_apiuser
    class Icinga2Apiuser < Chef::Resource
      identity_attr :name

      allowed_actions [:create, :delete, :nothing]

      provides :icinga2_apiuser

      default_action :create

      resource_name :icinga2_apiuser

      def initialize(name, run_context = nil)
        super
        @provider = Chef::Provider::Icinga2Instance
        @name = name
      end

      def cookbook(arg = nil)
        set_or_return(
          :cookbook, arg,
          kind_of: String,
          default: 'icinga2'
        )
      end

      def password(arg = nil)
        set_or_return(
          :password, arg,
          kind_of: String,
          required: true,
          default: nil
        )
      end

      def permissions(arg = nil)
        set_or_return(
          :permissions, arg,
          kind_of: String,
          required: true,
          default: nil
        )
      end

      def client_cn(arg = nil)
        set_or_return(
          :client_cn, arg,
          kind_of: String,
          default: nil
        )
      end

      def template_support(arg = nil)
        set_or_return(
          :template_support, arg,
          kind_of: [FalseClass],
          default: false
        )
      end

      def resource_properties(arg = nil)
        set_or_return(
          :resource_properties, arg,
          kind_of: Array,
          default: %w(password permissions client_cn)
        )
      end
    end
  end
end
