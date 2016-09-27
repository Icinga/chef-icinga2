# frozen_string_literal: true
# resource
class Chef
  class Resource
    # provides icinga2_script
    class Icinga2Script < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :icinga2_script if respond_to?(:resource_name)
        @provides = :icinga2_script
        @provider = Chef::Provider::Icinga2Script
        @action = :create
        @allowed_actions = [:create, :delete, :nothing]
        @name = name
      end

      def source(arg = nil)
        set_or_return(
          :source, arg,
          :kind_of => String,
          :default => name
        )
      end

      def cookbook(arg = nil)
        set_or_return(
          :cookbook, arg,
          :required => true,
          :kind_of => String,
          :default => nil
        )
      end

      def variables(arg = nil)
        set_or_return(
          :variables, arg,
          :kind_of => Hash,
          :default => {}
        )
      end
    end
  end
end

# provider
class Chef
  class Provider
    # provides icinga2_script
    class Icinga2Script < Chef::Provider::LWRPBase
      provides :icinga2_script if respond_to?(:provides)

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
        t = template ::File.join(node['icinga2']['scripts_dir'], new_resource.name) do
          cookbook new_resource.cookbook
          source new_resource.source
          owner node['icinga2']['user']
          group node['icinga2']['group']
          mode 0o755
          variables new_resource.variables if new_resource.variables
          action new_resource.action
        end
        t.updated?
      end
    end
  end
end
