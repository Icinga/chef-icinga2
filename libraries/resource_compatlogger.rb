# frozen_string_literal: true
# resource
class Chef
  class Resource
    # provides icinga2_compatlogger
    class Icinga2Compatlogger < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :icinga2_compatlogger if respond_to?(:resource_name)
        @provides = :icinga2_compatlogger
        @provider = Chef::Provider::Icinga2Compatlogger
        @action = :create
        @allowed_actions = [:create, :delete, :nothing]
        @name = name
      end

      def library(arg = nil)
        set_or_return(
          :library, arg,
          :kind_of => String,
          :default => 'compat'
        )
      end

      def log_dir(arg = nil)
        set_or_return(
          :log_dir, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def rotation_method(arg = nil)
        set_or_return(
          :rotation_method, arg,
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
    # provides icinga2_compatlogger
    class Icinga2Compatlogger < Chef::Provider::LWRPBase
      provides :icinga2_compatlogger if respond_to?(:provides)

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
                    :log_dir => new_resource.log_dir,
                    :library => new_resource.library,
                    :rotation_method => new_resource.rotation_method)
          notifies :reload, 'service[icinga2]'
        end
        ot.updated?
      end
    end
  end
end
