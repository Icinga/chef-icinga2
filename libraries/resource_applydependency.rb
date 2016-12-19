# frozen_string_literal: true
class Chef
  class Resource
    # provides icinga2_applydependency
    class Icinga2Applydependency < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :icinga2_applydependency if respond_to?(:resource_name)
        @provides = :icinga2_applydependency
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

      def object_relation(arg = nil)
        set_or_return(
          :object_relation, arg,
          :kind_of => String,
          :default => 'to'
        )
      end

      def object_type(arg = nil)
        set_or_return(
          :object_type, arg,
          :kind_of => String,
          :required => true,
          :default => nil
        )
      end

      def parent_host_name(arg = nil)
        set_or_return(
          :parent_host_name, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def child_host_name(arg = nil)
        set_or_return(
          :child_host_name, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def parent_service_name(arg = nil)
        set_or_return(
          :parent_service_name, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def child_service_name(arg = nil)
        set_or_return(
          :child_service_name, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def disable_checks(arg = nil)
        set_or_return(
          :disable_checks, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => nil
        )
      end

      def disable_notifications(arg = nil)
        set_or_return(
          :disable_notifications, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => nil
        )
      end

      def period(arg = nil)
        set_or_return(
          :period, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def states(arg = nil)
        set_or_return(
          :states, arg,
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

      def assign_where(arg = nil)
        set_or_return(
          :assign_where, arg,
          :kind_of => Array,
          :default => nil
        )
      end

      def ignore_where(arg = nil)
        set_or_return(
          :ignore_where, arg,
          :kind_of => Array,
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
          :default => %w(object_relation object_type parent_host_name child_host_name parent_service_name child_service_name disable_checks disable_notifications period states zone assign_where ignore_where)
        )
      end
    end
  end
end
