# frozen_string_literal: true
class Chef
  class Resource
    # provides icinga2_eventcommand
    class Icinga2Eventcommand < Chef::Resource
      identity_attr :name

      def cookbook(arg = nil)
        set_or_return(
          :cookbook, arg,
          :kind_of => String,
          :default => 'icinga2'
        )
      end

      def initialize(name, run_context = nil)
        super
        @resource_name = :icinga2_eventcommand if respond_to?(:resource_name)
        @provides = :icinga2_eventcommand
        @provider = Chef::Provider::Icinga2Instance
        @action = :create
        @allowed_actions = [:create, :delete, :nothing]
        @name = name
      end

      def import(arg = nil)
        set_or_return(
          :import, arg,
          :kind_of => String,
          :default => 'plugin-event-command'
        )
      end

      def command(arg = nil)
        set_or_return(
          :command, arg,
          :kind_of => [String, Array],
          :default => nil
        )
      end

      def env(arg = nil)
        set_or_return(
          :env, arg,
          :kind_of => Hash,
          :default => nil
        )
      end

      def timeout(arg = nil)
        set_or_return(
          :timeout, arg,
          :kind_of => [String, Integer],
          :default => nil
        )
      end

      def arguments(arg = nil)
        set_or_return(
          :arguments, arg,
          :kind_of => Hash,
          :default => {}
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
          :default => %w(import command env timeout arguments custom_vars template)
        )
      end
    end
  end
end
