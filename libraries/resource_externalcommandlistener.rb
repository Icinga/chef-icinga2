# frozen_string_literal: true
# resource
class Chef
  class Resource
    # provides icinga2_externalcommandlistener
    class Icinga2Externalcommandlistener < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :icinga2_externalcommandlistener if respond_to?(:resource_name)
        @provides = :icinga2_externalcommandlistener
        @provider = Chef::Provider::Icinga2Externalcommandlistener
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

      def command_path(arg = nil)
        set_or_return(
          :command_path, arg,
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
    # provides icinga2_externalcommandlistener
    class Icinga2Externalcommandlistener < Chef::Provider::LWRPBase
      provides :icinga2_externalcommandlistener if respond_to?(:provides)

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
                    :command_path => new_resource.command_path)
          notifies :reload, 'service[icinga2]'
        end
        ot.updated?
      end
    end
  end
end
