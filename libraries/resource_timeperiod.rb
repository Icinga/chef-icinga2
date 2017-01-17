# frozen_string_literal: true
class Chef
  class Resource
    # provides icinga2_timeperiod
    class Icinga2Timeperiod < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :icinga2_timeperiod if respond_to?(:resource_name)
        @provides = :icinga2_timeperiod
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

      def display_name(arg = nil)
        set_or_return(
          :display_name, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def import(arg = nil)
        set_or_return(
          :import, arg,
          :kind_of => String,
          :default => 'legacy-timeperiod'
        )
      end

      def ranges(arg = nil)
        set_or_return(
          :ranges, arg,
          :kind_of => Hash,
          :default => {}
        )
      end

      def zone(arg = nil)
        set_or_return(
          :zone, arg,
          :kind_of => String,
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
          :default => %w(display_name ranges zone import template)
        )
      end
    end
  end
end
