# frozen_string_literal: true
# resource
class Chef
  class Resource
    # provides icinga2_feature
    class Icinga2Feature < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :icinga2_feature if respond_to?(:resource_name)
        @provides = :icinga2_feature
        @provider = Chef::Provider::Icinga2Feature
        @action = :enable
        @allowed_actions = [:enable, :disable, :nothing]
        @name = name
      end
    end
  end
end

# provider
class Chef
  class Provider
    # provides icinga2_feature
    class Icinga2Feature < Chef::Provider::LWRPBase
      provides :icinga2_feature if respond_to?(:provides)

      def whyrun_supported?
        true
      end

      action :enable do
        raise "feature not available - #{new_resource.name}" unless ::File.exist?(::File.join(node['icinga2']['features_available_dir'], "#{new_resource.name}.conf"))

        unless ::File.exist?(::File.join(node['icinga2']['features_enabled_dir'], "#{new_resource.name}.conf"))
          execute "enable_feature_#{new_resource.name}" do
            command "/usr/sbin/icinga2 feature enable #{new_resource.name}"
            creates ::File.join(node['icinga2']['features_enabled_dir'], "#{new_resource.name}.conf")
            notifies platform?('windows') ? :restart : :reload, 'service[icinga2]'
          end
          new_resource.updated_by_last_action(true)
        end
      end

      def action_disable
        if ::File.exist?(::File.join(node['icinga2']['features_enabled_dir'], "#{new_resource.name}.conf"))
          execute "disable_feature_#{new_resource.name}" do
            command "/usr/sbin/icinga2 feature disable #{new_resource.name}"
            notifies platform?('windows') ? :restart : :reload, 'service[icinga2]'
          end
          new_resource.updated_by_last_action(true)
        end
      end
    end
  end
end
