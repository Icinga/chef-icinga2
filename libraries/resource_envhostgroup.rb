# frozen_string_literal: true
# resource
class Chef
  class Resource
    # provides icinga2_envhostgroup
    class Icinga2Envhostgroup < Chef::Resource
      identity_attr :name

      allowed_actions [:create, :delete, :nothing]

      default_action :create

      resource_name :icinga2_envhostgroup

      def initialize(name, run_context = nil)
        super
        @provider = Chef::Provider::Icinga2Envhostgroup
        @name = name
      end

      def environment(arg = nil)
        set_or_return(
          :environment, arg,
          kind_of: String,
          default: @name
        )
      end

      def zone(arg = nil)
        set_or_return(
          :zone, arg,
          kind_of: String,
          default: nil
        )
      end

      def groups(arg = nil)
        set_or_return(
          :groups, arg,
          kind_of: Array,
          default: []
        )
      end
    end
  end
end

# provider
class Chef
  class Provider
    # provides icinga2_envhostgroup
    class Icinga2Envhostgroup < Chef::Provider::LWRPBase
      provides :icinga2_envhostgroup

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
          mode '640'
          variables(environment: new_resource.environment, groups: new_resource.groups)
          notifies platform?('windows') ? :restart : :reload, 'service[icinga2]'
        end
        ot.updated?
      end
    end
  end
end
