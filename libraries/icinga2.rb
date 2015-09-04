def evaluate_quotes(value)
  return value unless value.is_a? String
  if value.to_s.match(/\+|{{(.*?)}}/m)
    value
  else
    value.inspect
  end
end

def icinga2_resource_create?(a)
  if a.is_a?(Array) && a == [:create]
    true
  elsif a.is_a?(Symbol) && a == :create
    true
  elsif a.is_a?(String) && a == 'create'
    true
  else
    false
  end
end

# the template icinga definition should be placed to a separate file with '_template' suffix in the filename
# in order to do that for objects assigned to a zone, this function separate the object into two hashes
def separateZoneResources(zone_objects)
  objectResources = Hash.new
  templateResources = Hash.new

  zone_objects.each do |resourceKey, resourceObject|
    if resourceObject['object_class'] == 'object'
      objectResources[resourceKey] = resourceObject
    elsif resourceObject['object_class'] == 'template'
      templateResources[resourceKey] = resourceObject
    else
      Chef::Application.fatal!("Unknown object_class (#{resourceObject['object_class']}), resourceKey=#{resourceKey}, resourceObject=#{resourceObject}", 1) 
    end
  end

  [objectResources, templateResources]
end


def processIcinga2Resources(resource_name, resource_keys, object_resources, template_support)
  icinga2_objects = {}
  # default value for a new key in the hash is an empty hash
  # key is a zone name, the hash for the key keeps an objet definitions, each unique, each is a hash again
  icinga2_zoned_objects = Hash.new { |h, k| h[k] = {} }

  object_resources.reduce({}) do |_hash, resource|
    next if !icinga2_resource_create?(resource.action) || icinga2_objects.key?(resource.name)
    resource_data = Hash[resource_keys.map {|x| [x, resource.send(x)]}]

    # not all icinga object support templating
    # the object_class have to be determined in any case
    if template_support
      if resource.send('template')
        resource_data['object_class'] = 'template'
      else
        resource_data['object_class'] = 'object'
      end
    else
      resource_data['object_class'] = 'object'
    end

    # TODO check first is such an object/key exist already, print a warning if so
    # if resource.send('template') && !icinga2_objects.key?(resource.name)
    if resource_data['zone']
      icinga2_zoned_objects[resource_data['zone']][resource.name] = resource_data
    else
      icinga2_objects[resource.name] = resource_data
    end
  end

  # separate object and teplate icinga definitions
  icinga2_objects_grouped = icinga2_objects.group_by { |k,v| v['object_class']}
  # now, this might be better refactored into a simple function with a simple loop, because I don't think I'll be
  # able to understand immediatelly after a halt year or so
  # what is does, it just produces a hash, with two keys, 'object' and 'template', under a key is another hash with
  # icinga object definitions, which are then processed by a template resource and ERB template file
  icinga2_objects_dict = icinga2_objects_grouped.keys.each_with_object({'object' => {}, 'template' => {}}) { |str,hash| hash[str] = Hash[icinga2_objects_grouped[str]]}

  ot = template ::File.join(node['icinga2']['objects_dir'], "#{resource_name}.conf") do
    source "object.#{resource_name}.conf.erb"
    cookbook 'icinga2'
    owner node['icinga2']['user']
    group node['icinga2']['group']
    mode 0640
    variables(:objects => icinga2_objects_dict['object'])
    notifies :reload, 'service[icinga2]', :delayed
    only_if { icinga2_objects_dict['object'].length > 0 }
  end

  te = template ::File.join(node['icinga2']['objects_dir'], "#{resource_name}_template.conf") do
    source "object.#{resource_name}.conf.erb"
    cookbook 'icinga2'
    owner node['icinga2']['user']
    group node['icinga2']['group']
    mode 0640
    variables(:objects => icinga2_objects_dict['template'])
    notifies :reload, 'service[icinga2]', :delayed
    only_if { icinga2_objects_dict['template'].length > 0 }
  end

  zoned_objects_updated = false

  icinga2_zoned_objects.each do |zone, zone_objects|

    directory ::File.join(node['icinga2']['zones_dir'], zone) do
      owner node['icinga2']['user']
      group node['icinga2']['group']
      action :create
      only_if { zone_objects.length > 0 }
    end

    zoned_objects, zoned_templates = separateZoneResources(zone_objects)

    zoned_ot = template ::File.join(node['icinga2']['zones_dir'], zone, "#{resource_name}.conf") do
      source "object.#{resource_name}.conf.erb"
      cookbook 'icinga2'
      owner node['icinga2']['user']
      group node['icinga2']['group']
      mode 0640
      variables(:objects => zoned_objects)
      notifies :reload, 'service[icinga2]', :delayed
      only_if { zoned_objects.length > 0 }
    end

    zoned_te = template ::File.join(node['icinga2']['zones_dir'], zone, "#{resource_name}_template.conf") do
      source "object.#{resource_name}.conf.erb"
      cookbook 'icinga2'
      owner node['icinga2']['user']
      group node['icinga2']['group']
      mode 0640
      variables(:objects => zoned_templates)
      notifies :reload, 'service[icinga2]', :delayed
      only_if { zoned_templates.length > 0 }
    end

    if zoned_ot.updated? || zoned_te.updated?
      zoned_objects_updated = true
    end

  end

  ot.updated? || te.updated? || zoned_objects_updated

end
