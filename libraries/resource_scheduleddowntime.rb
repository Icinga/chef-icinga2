# frozen_string_literal: true
class Chef
  class Resource
    # provides icinga2_scheduleddowntime
    class Icinga2Scheduleddowntime < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :icinga2_scheduleddowntime if respond_to?(:resource_name)
        @provides = :icinga2_scheduleddowntime
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

      def author(arg = nil)
        set_or_return(
          :author, arg,
          :required => true,
          :kind_of => String,
          :default => nil
        )
      end

      def comment(arg = nil)
        set_or_return(
          :comment, arg,
          :required => true,
          :kind_of => String,
          :default => nil
        )
      end

      def fixed(arg = nil)
        set_or_return(
          :fixed, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => nil
        )
      end

      def duration(arg = nil)
        set_or_return(
          :duration, arg,
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

      def ranges(arg = nil)
        set_or_return(
          :ranges, arg,
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
          :default => %w(host_name service_name author comment fixed duration zone ranges template)
        )
      end
    end
  end
end
