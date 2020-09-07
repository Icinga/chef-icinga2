resource_name :icinga2_idopgsqlconnection if respond_to?(:resource_name)
provides :icinga2_idopgsqlconnection
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'
property :library, String, default: 'perfdata'
property :host_perfdata_path, String
property :service_perfdata_path, String
property :host_temp_path, String
property :service_temp_path, String
property :host_format_template, String
property :service_format_template, String
property :rotation_interval, [String, Integer], regex: [/^\d+[smhd]$/]

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
                host_perfdata_path: new_resource.host_perfdata_path,
                service_perfdata_path: new_resource.service_perfdata_path,
                host_temp_path: new_resource.host_temp_path,
                service_temp_path: new_resource.service_temp_path,
                host_format_template: new_resource.host_format_template,
                service_format_template: new_resource.service_format_template,
                rotation_interval: new_resource.rotation_interval)
      notifies platform?('windows') ? :restart : :reload, 'service[icinga2]'
    end
    ot.updated?
  end
end
