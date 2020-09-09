resource_name :icinga2_feature
provides :icinga2_feature

property :cookbook, String, default: 'icinga2'
action :enable do
  raise "feature not available - #{new_resource.name}" unless ::File.exist?(::File.join(node['icinga2']['features_available_dir'], "#{new_resource.name}.conf"))
  unless ::File.exist?(::File.join(node['icinga2']['features_enabled_dir'], "#{new_resource.name}.conf"))
    execute "enable_feature_#{new_resource.name}" do
      command "/usr/sbin/icinga2 feature enable #{new_resource.name}"
      creates ::File.join(node['icinga2']['features_enabled_dir'], "#{new_resource.name}.conf")
      notifies platform?('windows') ? :restart : :reload, 'service[icinga2]'
    end
    new_resource.updated_by_last_action(true)
  end
end

action :disable do
  if ::File.exist?(::File.join(node['icinga2']['features_enabled_dir'], "#{new_resource.name}.conf"))
    execute "disable_feature_#{new_resource.name}" do
      command "/usr/sbin/icinga2 feature disable #{new_resource.name}"
      notifies platform?('windows') ? :restart : :reload, 'service[icinga2]'
    end
    new_resource.updated_by_last_action(true)
  end
end
