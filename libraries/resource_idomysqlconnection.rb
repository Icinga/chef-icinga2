# frozen_string_literal: true
# resource
class Chef
  class Resource
    # provides icinga2_idomysqlconnection
    class Icinga2Idomysqlconnection < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :icinga2_idomysqlconnection if respond_to?(:resource_name)
        @provides = :icinga2_idomysqlconnection
        @provider = Chef::Provider::Icinga2Idomysqlconnection
        @action = :create
        @allowed_actions = [:create, :delete, :nothing]
        @name = name
      end

      def library(arg = nil)
        set_or_return(
          :library, arg,
          :kind_of => String,
          :default => 'db_ido_mysql'
        )
      end

      def host(arg = nil)
        set_or_return(
          :host, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def port(arg = nil)
        set_or_return(
          :port, arg,
          :kind_of => Integer,
          :default => nil
        )
      end

      def user(arg = nil)
        set_or_return(
          :user, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def password(arg = nil)
        set_or_return(
          :password, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def database(arg = nil)
        set_or_return(
          :database, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def table_prefix(arg = nil)
        set_or_return(
          :table_prefix, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def instance_name(arg = nil)
        set_or_return(
          :instance_name, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def instance_description(arg = nil)
        set_or_return(
          :instance_description, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def enable_ha(arg = nil)
        set_or_return(
          :enable_ha, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => nil
        )
      end

      def failover_timeout(arg = nil)
        set_or_return(
          :failover_timeout, arg,
          :kind_of => [String, Integer],
          :default => nil
        )
      end

      def cleanup(arg = nil)
        set_or_return(
          :cleanup, arg,
          :kind_of => Hash,
          :default => nil
        )
      end

      def categories(arg = nil)
        set_or_return(
          :categories, arg,
          :kind_of => Array,
          :default => nil
        )
      end
    end
  end
end

# provider
class Chef
  class Provider
    # provides icinga2_idomysqlconnection
    class Icinga2Idomysqlconnection < Chef::Provider::LWRPBase
      provides :icinga2_idomysqlconnection if respond_to?(:provides)

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
                    :host => new_resource.host,
                    :port => new_resource.port,
                    :user => new_resource.user,
                    :password => new_resource.password,
                    :database => new_resource.database,
                    :table_prefix => new_resource.table_prefix,
                    :instance_name => new_resource.instance_name,
                    :instance_description => new_resource.instance_description,
                    :enable_ha => new_resource.enable_ha,
                    :failover_timeout => new_resource.failover_timeout,
                    :cleanup => new_resource.cleanup,
                    :categories => new_resource.categories)
          notifies platform?('windows') ? :restart : :reload, 'service[icinga2]'
        end
        ot.updated?
      end
    end
  end
end
