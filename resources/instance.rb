provides :icinga2_instance if respond_to?(:provides)

def whyrun_supported?
  true
end

action :create do
  object_template
end

action :delete do
  object_template
end

# create object resource
def object_template
  process_icinga2_resources(new_resource.resource_name.to_s.gsub('icinga2_', ''), new_resource.resource_properties, new_resource.template_support)
end
