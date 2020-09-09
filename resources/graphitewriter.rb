resource_name :icinga2_graphitewriter
provides :icinga2_graphitewriter

property :cookbook, String, default: 'icinga2'
property :library, String, default: 'perfdata'
property :host, String
property :port, Integer
property :host_name_template, String
property :service_name_template, String

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
                host: new_resource.host,
                port: new_resource.port,
                host_name_template: new_resource.host_name_template,
                service_name_template: new_resource.service_name_template)
      notifies platform?('windows') ? :restart : :reload, 'service[icinga2]'
    end
    ot.updated?
  end
end
