# frozen_string_literal: true
# resource
class Chef
  class Resource
    # provides icinga2_perfdatawriter
    class Icinga2Perfdatawriter < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :icinga2_perfdatawriter if respond_to?(:resource_name)
        @provides = :icinga2_perfdatawriter
        @provider = Chef::Provider::Icinga2Perfdatawriter
        @action = :create
        @allowed_actions = [:create, :delete, :nothing]
        @name = name
      end

      def library(arg = nil)
        set_or_return(
          :library, arg,
          :kind_of => String,
          :default => 'perfdata'
        )
      end

      def host_perfdata_path(arg = nil)
        set_or_return(
          :host_perfdata_path, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def service_perfdata_path(arg = nil)
        set_or_return(
          :service_perfdata_path, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def host_temp_path(arg = nil)
        set_or_return(
          :host_temp_path, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def service_temp_path(arg = nil)
        set_or_return(
          :service_temp_path, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def host_format_template(arg = nil)
        set_or_return(
          :host_format_template, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def service_format_template(arg = nil)
        set_or_return(
          :service_format_template, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def rotation_interval(arg = nil)
        set_or_return(
          :rotation_interval, arg,
          :regex => /^\d+[smhd]$/,
          :kind_of => [String, Integer],
          :default => nil
        )
      end
    end
  end
end

# provider
class Chef
  class Provider
    # provides icinga2_gelfwriter
    class Icinga2Perfdatawriter < Chef::Provider::LWRPBase
      provides :icinga2_perfdatawriter if respond_to?(:provides)

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
                    :host_perfdata_path => new_resource.host_perfdata_path,
                    :service_perfdata_path => new_resource.service_perfdata_path,
                    :host_temp_path => new_resource.host_temp_path,
                    :service_temp_path => new_resource.service_temp_path,
                    :host_format_template => new_resource.host_format_template,
                    :service_format_template => new_resource.service_format_template,
                    :rotation_interval => new_resource.rotation_interval)
          notifies :reload, 'service[icinga2]'
        end
        ot.updated?
      end
    end
  end
end
