resource_name :icinga2_sysloglogger if respond_to?(:resource_name)
provides :icinga2_sysloglogger
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'
property :severity, String

def whyrun_supported?
  true
end

action :create do
  new_resource.updated_by_last_action(object_template)
end

action :delete do
  new_resource.updated_by_last_action(object_template)
end



def object_template
  resource_name = new_resource.resource_name.to_s.gsub('icinga2_', '')
  ot = template ::File.join(node['icinga2']['objects_dir'], "#{resource_name}.conf") do
    source "object.#{resource_name}.conf.erb"
    cookbook 'icinga2'
    owner node['icinga2']['user']
    group node['icinga2']['group']
    mode 0o640
    variables(object: new_resource.name,
              severity: new_resource.severity)
    notifies platform?('windows') ? :restart : :reload, 'service[icinga2]'
  end
  ot.updated?
end
