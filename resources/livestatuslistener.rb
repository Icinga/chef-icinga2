resource_name :icinga2_livestatuslistener
provides :icinga2_livestatuslistener

property :cookbook, String, default: 'icinga2'
property :library, String, default: 'livestatus'
property :socket_type, String
property :bind_host, Integer
property :bind_port, String
property :socket_path, String
property :compat_log_path, String

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
      mode '640'
      variables(object: new_resource.name,
                library: new_resource.library,
                socket_type: new_resource.socket_type,
                bind_host: new_resource.bind_host,
                bind_port: new_resource.bind_port,
                socket_path: new_resource.socket_path,
                compat_log_path: new_resource.compat_log_path)
      notifies platform?('windows') ? :restart : :reload, 'service[icinga2]'
    end
    ot.updated?
  end
end
