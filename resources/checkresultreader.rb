resource_name :icinga2_checkresultreader if respond_to?(:resource_name)
provides :icinga2_checkresultreader
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'
property :library, String, default: 'compat'
property :spool_dir, String

provides :icinga2_checkresultreader if respond_to?(:provides)

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
    variables(:object => new_resource.name,
              :spool_dir => new_resource.spool_dir,
              :library => new_resource.library)
    notifies platform?('windows') ? :restart : :reload, 'service[icinga2]'
  end
  ot.updated?
end
