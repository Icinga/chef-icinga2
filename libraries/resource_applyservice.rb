# frozen_string_literal: true
class Chef
  class Resource
    # provides icinga2_applyservice
    class Icinga2Applyservice < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :icinga2_applyservice if respond_to?(:resource_name)
        @provides = :icinga2_applyservice
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

      def groups(arg = nil)
        set_or_return(
          :groups, arg,
          :kind_of => Array,
          :default => nil
        )
      end

      def check_command(arg = nil)
        set_or_return(
          :check_command, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def max_check_attempts(arg = nil)
        set_or_return(
          :max_check_attempts, arg,
          :kind_of => Integer,
          :default => nil
        )
      end

      def check_period(arg = nil)
        set_or_return(
          :check_period, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def notification_period(arg = nil)
        set_or_return(
          :notification_period, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def check_interval(arg = nil)
        set_or_return(
          :check_interval, arg,
          :kind_of => [String, Integer],
          :default => nil
        )
      end

      def retry_interval(arg = nil)
        set_or_return(
          :retry_interval, arg,
          :kind_of => [String, Integer],
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

      def enable_active_checks(arg = nil)
        set_or_return(
          :enable_active_checks, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => nil
        )
      end

      def enable_passive_checks(arg = nil)
        set_or_return(
          :enable_passive_checks, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => nil
        )
      end

      def enable_event_handler(arg = nil)
        set_or_return(
          :enable_event_handler, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => nil
        )
      end

      def enable_flapping(arg = nil)
        set_or_return(
          :enable_flapping, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => nil
        )
      end

      def enable_perfdata(arg = nil)
        set_or_return(
          :enable_perfdata, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => nil
        )
      end

      def event_command(arg = nil)
        set_or_return(
          :event_command, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def flapping_threshold(arg = nil)
        set_or_return(
          :flapping_threshold, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def volatile(arg = nil)
        set_or_return(
          :volatile, arg,
          :kind_of => [TrueClass, FalseClass],
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

      def command_endpoint(arg = nil)
        set_or_return(
          :command_endpoint, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def notes(arg = nil)
        set_or_return(
          :notes, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def notes_url(arg = nil)
        set_or_return(
          :notes_url, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def action_url(arg = nil)
        set_or_return(
          :action_url, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def icon_image(arg = nil)
        set_or_return(
          :icon_image, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def icon_image_alt(arg = nil)
        set_or_return(
          :icon_image_alt, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def merge_vars(arg = nil)
        set_or_return(
          :merge_vars, arg,
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

      def set(arg = nil)
        set_or_return(
          :set, arg,
          :kind_of => String,
          :regex => /^[a-z|_]+\s=>\s[a-z|_]+\sin\s\S+$/,
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
          :default => %w(import display_name host_name groups check_command max_check_attempts check_period notification_period check_interval retry_interval enable_notifications enable_active_checks enable_passive_checks enable_event_handler enable_flapping enable_perfdata event_command flapping_threshold volatile zone command_endpoint notes notes_url action_url icon_image icon_image_alt merge_vars custom_vars assign_where ignore_where set)
        )
      end
    end
  end
end
