resource_name :icinga2_idopgsqlconnection if respond_to?(:resource_name)
provides :icinga2_idopgsqlconnection
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'
property :library, String, default: 'db_ido_pgsql'
property :host, String
property :port, Integer
property :user, String
property :password, String
property :socket_path, String
property :database, String
property :table_prefix, String
property :instance_name, String
property :instance_description, String
property :enable_ha, [TrueClass, FalseClass]
property :failover_timeout, [String, Integer]
property :cleanup, Hash
property :categories, Array

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
                user: new_resource.user,
                password: new_resource.password,
                database: new_resource.database,
                socket_path: new_resource.socket_path,
                table_prefix: new_resource.table_prefix,
                instance_name: new_resource.instance_name,
                instance_description: new_resource.instance_description,
                enable_ha: new_resource.enable_ha,
                failover_timeout: new_resource.failover_timeout,
                cleanup: new_resource.cleanup,
                categories: new_resource.categories)
      notifies platform?('windows') ? :restart : :reload, 'service[icinga2]'
    end
    ot.updated?
  end
end
