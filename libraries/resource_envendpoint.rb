# frozen_string_literal: true
# resource
class Chef
  class Resource
    # provides icinga2_envendpoint
    class Icinga2Envendpoint < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :icinga2_envendpoint if respond_to?(:resource_name)
        @provides = :icinga2_envendpoint
        @provider = Chef::Provider::Icinga2Envendpoint
        @action = :create
        @allowed_actions = [:create, :delete, :nothing]
        @name = name
      end

      def environment(arg = nil)
        set_or_return(
          :environment, arg,
          :kind_of => String,
          :default => @name
        )
      end

      def zone(arg = nil)
        set_or_return(
          :zone, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def port(arg = nil)
        set_or_return(
          :port, arg,
          :kind_of => Integer,
          :default => node['icinga2']['endpoint_port']
        )
      end

      def log_duration(arg = nil)
        set_or_return(
          :log_duration, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def endpoints(arg = nil)
        set_or_return(
          :endpoints, arg,
          :kind_of => Array,
          :default => []
        )
      end
    end
  end
end

# provider
class Chef
  class Provider
    # provides icinga2_envendpoint
    class Icinga2Envendpoint < Chef::Provider::LWRPBase
      provides :icinga2_envendpoint if respond_to?(:provides)

      def whyrun_supported?
        true
      end

      action :create do
        new_resource.updated_by_last_action(object_template)
      end

      action :delete do
        new_resource.updated_by_last_action(object_template)
      end

      protected

      def object_template
        resource_name = new_resource.resource_name.to_s.gsub('icinga2_', '')

        template_file_name = new_resource.zone ? "#{resource_name}_#{new_resource.environment}_#{new_resource.zone}.conf" : "#{resource_name}_#{new_resource.environment}.conf"

        if new_resource.zone
          env_resources_path = ::File.join(node['icinga2']['zones_dir'], new_resource.zone, template_file_name)

          directory ::File.join(node['icinga2']['zones_dir'], new_resource.zone) do
            owner node['icinga2']['user']
            group node['icinga2']['group']
          end
        else
          env_resources_path = ::File.join(node['icinga2']['objects_dir'], template_file_name)
        end

        ot = template env_resources_path do
          source "object.#{resource_name}.conf.erb"
          cookbook 'icinga2'
          owner node['icinga2']['user']
          group node['icinga2']['group']
          mode 0o640
          variables(
            :environment => new_resource.environment,
            :endpoints => new_resource.endpoints,
            :log_duration => new_resource.log_duration
          )
          notifies platform?('windows') ? :restart : :reload, 'service[icinga2]'
        end
        ot.updated?
      end
    end
  end
end
