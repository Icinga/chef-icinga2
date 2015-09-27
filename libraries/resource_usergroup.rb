# resource
class Chef
  class Resource
    # provides icinga2_usergroup
    class Icinga2Usergroup < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :icinga2_usergroup if respond_to?(:resource_name)
        @provides = :icinga2_usergroup
        @provider = Chef::Provider::Icinga2Instance
        @action = :create
        @allowed_actions = [:create, :delete, :nothing]
        @name = name
      end

      def display_name(arg = nil)
        set_or_return(
          :display_name, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def groups(arg = nil)
        set_or_return(
          :groups, arg,
          :kind_of => Array,
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
          :default => %w(display_name groups zone)
        )
      end
    end
  end
end
