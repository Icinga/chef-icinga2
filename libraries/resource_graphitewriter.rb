# frozen_string_literal: true
# resource
class Chef
  class Resource
    # provides icinga2_graphitewriter
    class Icinga2Graphitewriter < Chef::Resource
      identity_attr :name

      allowed_actions [:create, :delete, :nothing]

      default_action :create

      resource_name :icinga2_graphitewriter

      def initialize(name, run_context = nil)
        super
        @provider = Chef::Provider::Icinga2Graphitewriter
        @name = name
      end

      def library(arg = nil)
        set_or_return(
          :library, arg,
          kind_of: String,
          default: 'perfdata'
        )
      end

      def host(arg = nil)
        set_or_return(
          :host, arg,
          kind_of: String,
          default: nil
        )
      end

      def port(arg = nil)
        set_or_return(
          :port, arg,
          kind_of: Integer,
          default: nil
        )
      end

      def host_name_template(arg = nil)
        set_or_return(
          :host_name_template, arg,
          kind_of: String,
          default: nil
        )
      end

      def service_name_template(arg = nil)
        set_or_return(
          :service_name_template, arg,
          kind_of: String,
          default: nil
        )
      end
    end
  end
end

# provider
class Chef
  class Provider
    # provides icinga2_graphitewriter
    class Icinga2Graphitewriter < Chef::Provider::LWRPBase
      provides :icinga2_graphitewriter

      action :create do
        new_resource.updated_by_last_action(object_template)
      end

      action :delete do
        new_resource.updated_by_last_action(object_template)
      end

      protected

      def object_template
        resource_name = new_resource.resource_name.to_s.gsub('icinga2_', '')
        ot = template ::File.join(node['icinga2']['objects_dir'], "#{resource_name}.conf") do
          source "object.#{resource_name}.conf.erb"
          cookbook 'icinga2'
          owner node['icinga2']['user']
          group node['icinga2']['group']
          mode '640'
          variables(object: new_resource.name,
                    library: new_resource.library,
                    host: new_resource.host,
                    port: new_resource.port,
                    host_name_template: new_resource.host_name_template,
                    service_name_template: new_resource.service_name_template)
          notifies platform?('windows') ? :restart : :reload, 'service[icinga2]'
        end
        ot.updated?
      end
    end
  end
end
