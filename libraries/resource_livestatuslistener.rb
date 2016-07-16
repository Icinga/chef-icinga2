# resource
class Chef
  class Resource
    # provides icinga2_livestatuslistener
    class Icinga2Livestatuslistener < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :icinga2_livestatuslistener if respond_to?(:resource_name)
        @provides = :icinga2_livestatuslistener
        @provider = Chef::Provider::Icinga2Livestatuslistener
        @action = :create
        @allowed_actions = [:create, :delete, :nothing]
        @name = name
      end

      def library(arg = nil)
        set_or_return(
          :library, arg,
          :kind_of => String,
          :default => 'livestatus'
        )
      end

      def socket_type(arg = nil)
        set_or_return(
          :socket_type, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def bind_host(arg = nil)
        set_or_return(
          :bind_host, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def bind_port(arg = nil)
        set_or_return(
          :bind_port, arg,
          :kind_of => Integer,
          :default => nil
        )
      end

      def socket_path(arg = nil)
        set_or_return(
          :socket_path, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def compat_log_path(arg = nil)
        set_or_return(
          :compat_log_path, arg,
          :kind_of => String,
          :default => nil
        )
      end
    end
  end
end

# provider
class Chef
  class Provider
    # provides icinga2_livestatuslistener
    class Icinga2Livestatuslistener < Chef::Provider::LWRPBase
      provides :icinga2_livestatuslistener if respond_to?(:provides)

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
        ot = template ::File.join(node['icinga2']['objects_dir'], "#{resource_name}.conf") do
          source "object.#{resource_name}.conf.erb"
          cookbook 'icinga2'
          owner node['icinga2']['user']
          group node['icinga2']['group']
          mode 0o640
          variables(:object => new_resource.name,
                    :library => new_resource.library,
                    :socket_type => new_resource.socket_type,
                    :bind_host => new_resource.bind_host,
                    :bind_port => new_resource.bind_port,
                    :socket_path => new_resource.socket_path,
                    :compat_log_path => new_resource.compat_log_path)
          notifies :reload, 'service[icinga2]'
        end
        ot.updated?
      end
    end
  end
end
