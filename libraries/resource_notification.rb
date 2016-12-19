# frozen_string_literal: true
class Chef
  class Resource
    # provides icinga2_notification
    class Icinga2Notification < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :icinga2_notification if respond_to?(:resource_name)
        @provides = :icinga2_notification
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

      def host_name(arg = nil)
        set_or_return(
          :host_name, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def service_name(arg = nil)
        set_or_return(
          :service_name, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def users(arg = nil)
        set_or_return(
          :users, arg,
          :kind_of => Array,
          :default => nil
        )
      end

      def user_groups(arg = nil)
        set_or_return(
          :user_groups, arg,
          :kind_of => Array,
          :default => nil
        )
      end

      def command(arg = nil)
        set_or_return(
          :command, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def times(arg = nil)
        set_or_return(
          :times, arg,
          :kind_of => Hash,
          :default => nil
        )
      end

      def interval(arg = nil)
        set_or_return(
          :interval, arg,
          :kind_of => [String, Integer],
          :regex => /^\d+[smhd]$/,
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

      def zone(arg = nil)
        set_or_return(
          :zone, arg,
          :kind_of => String,
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

      def states(arg = nil)
        set_or_return(
          :states, arg,
          :kind_of => Array,
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
          :default => %w(import host_name service_name users user_groups times command interval period zone types states custom_vars template)
        )
      end
    end
  end
end
