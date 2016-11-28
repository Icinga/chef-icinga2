# frozen_string_literal: true
class Chef
  class Resource
    # provides icinga2_user
    class Icinga2User < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :icinga2_user if respond_to?(:resource_name)
        @provides = :icinga2_user
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

      def import(arg = nil)
        set_or_return(
          :import, arg,
          :kind_of => String,
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

      def email(arg = nil)
        set_or_return(
          :email, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def pager(arg = nil)
        set_or_return(
          :pager, arg,
          :kind_of => String,
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

      def types(arg = nil)
        set_or_return(
          :types, arg,
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

      def custom_vars(arg = nil)
        set_or_return(
          :custom_vars, arg,
          :kind_of => Hash,
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

      def template(arg = nil)
        set_or_return(
          :template, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => false
        )
      end

      def template_support(arg = nil)
        set_or_return(
          :template_support, arg,
          :kind_of => [TrueClass],
          :default => true
        )
      end

      def resource_properties(arg = nil)
        set_or_return(
          :resource_properties, arg,
          :kind_of => Array,
          :default => %w(import display_name groups email pager period states types zone custom_vars enable_notifications template)
        )
      end
    end
  end
end
