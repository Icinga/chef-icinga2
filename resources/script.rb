resource_name :icinga2_script if respond_to?(:resource_name)
provides :icinga2_script
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'
property :source, String
property :variables, Hash

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
  t = template ::File.join(node['icinga2']['scripts_dir'], new_resource.name) do
    cookbook new_resource.cookbook
    source new_resource.source
    owner node['icinga2']['user']
    group node['icinga2']['group']
    mode 0o755
    variables new_resource.variables if new_resource.variables
    action new_resource.action
  end
  t.updated?
end
