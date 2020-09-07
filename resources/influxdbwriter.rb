resource_name :icinga2_influxdbwriter if respond_to?(:resource_name)
provides :icinga2_influxdbwriter
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'

property :library, String, default: 'perfdata'
property :host, String, default: 'localhost'
property :port, Integer, default: 8087
property :username, String
property :password, String
property :socket_path, String
property :database, String, default: 'icinga2'

property :ssl_enable, [TrueClass, FalseClass], default: false
property :ssl_ca_cert, String
property :ssl_cert, String
property :ssl_key, String
property :host_template, String
property :service_template, String
property :enable_send_tresholds, String
property :enable_send_metadata, String
property :flush_interval, String
property :flush_threshold, String

def whyrun_supported?
  true
end

action :create do
  new_resource.updated_by_last_action(object_template)
end

action :delete do
  new_resource.updated_by_last_action(object_template)
end

action_class do
  def object_template
    resource_name = new_resource.resource_name.to_s.gsub('icinga2_', '')
    ot = template ::File.join(node['icinga2']['objects_dir'], "#{resource_name}.conf") do
      source "object.#{resource_name}.conf.erb"
      cookbook 'icinga2'
      owner node['icinga2']['user']
      group node['icinga2']['group']
      mode 0o640
      variables(object: new_resource.name,
                library: new_resource.library,
                host: new_resource.host,
                port: new_resource.port,
                database: new_resource.database,
                username: new_resource.username,
                password: new_resource.password,
                ssl_enable: new_resource.ssl_enable,
                ssl_ca_cert: new_resource.ssl_ca_cert,
                ssl_cert: new_resource.ssl_cert,
                ssl_key: new_resource.ssl_key,
                host_template: new_resource.host_template,
                service_template: new_resource.service_template,
                enable_send_thresholds: new_resource.enable_send_thresholds,
                enable_send_metadata: new_resource.enable_send_metadata,
                flush_interval: new_resource.flush_interval,
                flush_threshold: new_resource.flush_threshold)
      notifies platform?('windows') ? :restart : :reload, 'service[icinga2]'
    end
    ot.updated?
  end
end
