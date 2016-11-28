# frozen_string_literal: true
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

      def cookbook(arg = nil)
        set_or_return(
          :cookbook, arg,
          :kind_of => String,
          :default => 'icinga2'
        )
      end

      def assign_where(arg = nil)
        set_or_return(
          :assign_where, arg,
          :kind_of => Array,
          :default => nil
        )
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

      def ignore_where(arg = nil)
        set_or_return(
          :ignore_where, arg,
          :kind_of => Array,
          :default => nil
        )
      end

      def resource_properties(arg = nil)
        set_or_return(
          :resource_properties, arg,
          :kind_of => Array,
          :default => %w(assign_where ignore_where display_name groups zone)
        )
      end
    end
  end
end
