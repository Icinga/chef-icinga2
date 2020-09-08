resource_name :icinga2_user
provides :icinga2_user
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'
property :import, String
property :display_name, String
property :groups, Array
property :email, String
property :pager, String
property :period, String
property :states, Array
property :types, Array
property :zone, String
property :custom_vars, Hash
property :enable_notifications, [true, false]
property :template, [true, false], default: false
property :template_support, TrueClass, default: true
property :resource_properties, Array, default: %w(import display_name groups email pager period states types zone custom_vars enable_notifications template)

action :create do
  object_template
end

action :delete do
  object_template
end

action_class do
  include Icinga2::Cookbook::Instances
  def object_template
    object_resources = []
    object_resources << @new_resource
    process_icinga2_resources(new_resource.resource_name.to_s.gsub('icinga2_', ''), new_resource.resource_properties, new_resource.template_support, object_resources)
  end
end
