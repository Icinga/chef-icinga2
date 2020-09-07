# frozen_string_literal: true
# resource
class Chef
  class Resource
    # provides icinga2_zone
    class Icinga2Zone < Chef::Resource
      identity_attr :name

      allowed_actions [:create, :delete, :nothing]

      provides :icinga2_zone

      default_action :create

      resource_name :icinga2_zone

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

      def endpoints(arg = nil)
        set_or_return(
          :endpoints, arg,
          kind_of: Array,
          default: nil
        )
      end

      def parent(arg = nil)
        set_or_return(
          :parent, arg,
          kind_of: String,
          default: nil
        )
      end

      def global(arg = nil)
        set_or_return(
          :global, arg,
          kind_of: [TrueClass, FalseClass],
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
          default: %w(endpoints parent global)
        )
      end
    end
  end
end
