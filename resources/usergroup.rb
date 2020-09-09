include Icinga2::Cookbook::Instances
unified_mode true

resource_name :icinga2_usergroup
provides :icinga2_usergroup
allowed_actions [:create, :delete, :nothing]

property :cookbook, String, default: 'icinga2'
property :assign_where, Array
property :display_name, String
property :groups, Array
property :zone, String
property :ignore_where, Array
property :template_support, FalseClass, default: false
property :resource_properties, Array, default: %w(assign_where ignore_where display_name groups zone)

action :create do
  object_template
end

action :delete do
  object_template
end

action_class do
  include Icinga2::Cookbook::Instances
  def object_template
    # with_run_context :root do
    #   check_property = new_resource
    #     edit_resource(:icinga2_usergroup, check_property.check_name) do
    #     instances(instances + check_property.instances)
    #     init_config(init_config.merge(check_property.init_config))
    #     use_integration_template(check_property.generic)
    #     action :nothing
    #     delayed_action :add
    #   end
    # end

    process_icinga2_resources(new_resource.resource_name.to_s.gsub('icinga2_', ''), new_resource.resource_properties, new_resource.template_support)
  end
end
