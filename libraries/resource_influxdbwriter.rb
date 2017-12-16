# frozen_string_literal: true
# resource
class Chef
  class Resource
    # provides icinga2_influxdbwriter
    class Icinga2Influxdbwriter < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :icinga2_influxdbwriter if respond_to?(:resource_name)
        @provides = :icinga2_influxdbwriter
        @provider = Chef::Provider::Icinga2Influxdbwriter
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

      def host(arg = nil)
        set_or_return(
          :host, arg,
          :kind_of => String,
          :default => 'localhost'
        )
      end

      def port(arg = nil)
        set_or_return(
          :port, arg,
          :kind_of => Integer,
          :default => 8087
        )
      end

      def database(arg = nil)
        set_or_return(
          :database, arg,
          :kind_of => String,
          :default => 'icinga2'
        )
      end

      def username(arg = nil)
        set_or_return(
          :username, arg,
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

      def ssl_enable(arg = nil)
        set_or_return(
          :ssl_enable, arg,
          :kind_of => String,
          :default => false
        )
      end

      def ssl_ca_cert(arg = nil)
        set_or_return(
          :ssl_ca_cert, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def ssl_cert(arg = nil)
        set_or_return(
          :ssl_cert, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def ssl_key(arg = nil)
        set_or_return(
          :ssl_key, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def host_template(arg = nil)
        set_or_return(
          :host_template, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def service_template(arg = nil)
        set_or_return(
          :service_template, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def enable_send_thresholds(arg = nil)
        set_or_return(
          :enable_send_thresholds, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def enable_send_metadata(arg = nil)
        set_or_return(
          :enable_send_metadata, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def flush_interval(arg = nil)
        set_or_return(
          :flush_interval, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def flush_threshold(arg = nil)
        set_or_return(
          :flush_threshold, arg,
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
    # provides icinga2_influxdbwriter
    class Icinga2Influxdbwriter < Chef::Provider::LWRPBase
      provides :icinga2_influxdbwriter if respond_to?(:provides)

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
                    :database => new_resource.database,
                    :username => new_resource.username,
                    :password => new_resource.password,
                    :ssl_enable => new_resource.ssl_enable,
                    :ssl_ca_cert => new_resource.ssl_ca_cert,
                    :ssl_cert => new_resource.ssl_cert,
                    :ssl_key => new_resource.ssl_key,
                    :host_template => new_resource.host_template,
                    :service_template => new_resource.service_template,
                    :enable_send_thresholds => new_resource.enable_send_thresholds,
                    :enable_send_metadata => new_resource.enable_send_metadata,
                    :flush_interval => new_resource.flush_interval,
                    :flush_threshold => new_resource.flush_threshold)
          notifies platform?('windows') ? :restart : :reload, 'service[icinga2]'
        end
        ot.updated?
      end
    end
  end
end
