class Chef
  class Resource
    # provides icinga2_applynotification
    class Icinga2Applynotification < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :icinga2_applynotification if respond_to?(:resource_name)
        @provides = :icinga2_applynotification
        @provider = Chef::Provider::Icinga2Instance
        @action = :create
        @allowed_actions = [:create, :delete, :nothing]
        @name = name
      end

      def object_type(arg = nil)
        set_or_return(
          :object_type, arg,
          :required => true,
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

      def command(arg = nil)
        set_or_return(
          :command, arg,
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
          :regex => /^0|\d+[smhd]$/,
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
          :default => %w(object_type import command users user_groups interval period types states times assign_where ignore_where zone)
        )
      end
    end
  end
end
