# require 'chef/provider'
# require 'chef/resource'

class Chef
  class Provider
    # provides icinga2_instance
    class Icinga2Instance < Chef::Provider::LWRPBase
      provides :icinga2_instance if respond_to?(:provides)

      def whyrun_supported?
        true
      end

      action :create do
        new_resource.updated_by_last_action(object_template)
      end

      action :delete do
        new_resource.updated_by_last_action(object_template)
      end

      protected

      # collect object defined resources
      def object_resources
        run_context.resource_collection.select do |resource|
          case new_resource.resource_name
          when :icinga2_apilistener
            resource.is_a?(Chef::Resource::Icinga2Apilistener)
          when :icinga2_applydependency
            resource.is_a?(Chef::Resource::Icinga2Applydependency)
          when :icinga2_applynotification
            resource.is_a?(Chef::Resource::Icinga2Applynotification)
          when :icinga2_applyservice
            resource.is_a?(Chef::Resource::Icinga2Applyservice)
          when :icinga2_checkcommand
            resource.is_a?(Chef::Resource::Icinga2Checkcommand)
          when :icinga2_endpoint
            resource.is_a?(Chef::Resource::Icinga2Endpoint)
          when :icinga2_eventcommand
            resource.is_a?(Chef::Resource::Icinga2Eventcommand)
          when :icinga2_host
            resource.is_a?(Chef::Resource::Icinga2Host)
          when :icinga2_hostgroup
            resource.is_a?(Chef::Resource::Icinga2Hostgroup)
          when :icinga2_notification
            resource.is_a?(Chef::Resource::Icinga2Notification)
          when :icinga2_notificationcommand
            resource.is_a?(Chef::Resource::Icinga2Notificationcommand)
          when :icinga2_scheduleddowntime
            resource.is_a?(Chef::Resource::Icinga2Scheduleddowntime)
          when :icinga2_service
            resource.is_a?(Chef::Resource::Icinga2Service)
          when :icinga2_servicegroup
            resource.is_a?(Chef::Resource::Icinga2Servicegroup)
          when :icinga2_timeperiod
            resource.is_a?(Chef::Resource::Icinga2Timeperiod)
          when :icinga2_user
            resource.is_a?(Chef::Resource::Icinga2User)
          when :icinga2_usergroup
            resource.is_a?(Chef::Resource::Icinga2Usergroup)
          when :icinga2_zone
            resource.is_a?(Chef::Resource::Icinga2Zone)
          else
            raise "unknown resource type #{new_resource.resource_name}, submit a bug"
          end
        end
      end

      # create object resource
      def object_template
        process_icinga2_resources(new_resource.resource_name.to_s.gsub('icinga2_', ''), new_resource.resource_properties, new_resource.template_support)
      end

      # the template icinga definition should be placed to a separate file with '_template' suffix in the filename
      # in order to do that for objects assigned to a zone, this function separate the object into two hashes
      def separate_zone_resources(zone_objects)
        object_resources = {}
        template_resources = {}

        zone_objects.each do |resource_key, resource_object|
          if resource_object['object_class'] == 'object'
            object_resources[resource_key] = resource_object
          elsif resource_object['object_class'] == 'template'
            template_resources[resource_key] = resource_object
          else
            Chef::Application.fatal!("Unknown object_class (#{resource_object['object_class']}), resource_key=#{resource_key}, resource_object=#{resource_object}", 1)
          end
        end

        [object_resources, template_resources]
      end

      def process_icinga2_resources(resource_name, resource_properties, template_support)
        icinga2_objects = {}
        # default value for a new key in the hash is an empty hash
        # key is a zone name, the hash for the key keeps an object definitions, each unique, each is a hash again
        icinga2_zoned_objects = Hash.new { |h, k| h[k] = {} }

        object_resources.reduce({}) do |_hash, resource|
          next nil if !icinga2_resource_create?(resource.action) || icinga2_objects.key?(resource.name)
          resource_data = Hash[resource_properties.map { |x| [x, resource.send(x)] }]

          # not all icinga object support templating
          # the object_class have to be determined in any case
          resource_data['object_class'] = if template_support && resource.send('template')
                                            'template'
                                          else
                                            'object'
                                          end

          # TODO: check first is such an object/key exist already, print a warning if so
          # if resource.send('template') && !icinga2_objects.key?(resource.name)
          if resource_data['zone']
            icinga2_zoned_objects[resource_data['zone']][resource.name] = resource_data
          else
            icinga2_objects[resource.name] = resource_data
          end
        end

        # separate object and teplate icinga definitions
        icinga2_objects_grouped = icinga2_objects.group_by { |_k, v| v['object_class'] }
        # now, this might be better refactored into a simple function with a simple loop, because I don't think I'll be
        # able to understand immediatelly after a halt year or so
        # what is does, it just produces a hash, with two keys, 'object' and 'template', under a key is another hash with
        # icinga object definitions, which are then processed by a template resource and ERB template file
        icinga2_objects_dict = icinga2_objects_grouped.keys.each_with_object('object' => {}, 'template' => {}) { |str, hash| hash[str] = Hash[icinga2_objects_grouped[str]] }

        ot = template "object_config_#{resource_name}_#{new_resource.name}" do
          path ::File.join(node['icinga2']['objects_dir'], "#{resource_name}.conf")
          cookbook 'icinga2'
          source "object.#{resource_name}.conf.erb"
          owner node['icinga2']['user']
          group node['icinga2']['group']
          variables :objects => icinga2_objects_dict['object']
          notifies :reload, 'service[icinga2]'
          only_if { !icinga2_objects_dict['object'].empty? }
        end

        te = template "object_template_#{resource_name}_#{new_resource.name}" do
          path ::File.join(node['icinga2']['objects_dir'], "#{resource_name}_template.conf")
          source "object.#{resource_name}.conf.erb"
          cookbook 'icinga2'
          owner node['icinga2']['user']
          group node['icinga2']['group']
          mode 0o640
          variables :objects => icinga2_objects_dict['template']
          notifies :reload, 'service[icinga2]'
          only_if { !icinga2_objects_dict['template'].empty? }
        end

        zoned_objects_updated = false

        icinga2_zoned_objects.each do |zone, zone_objects|
          zone_dir = directory "zone_directory_#{resource_name}_#{zone}_#{new_resource.name}" do
            path ::File.join(node['icinga2']['zones_dir'], zone)
            owner node['icinga2']['user']
            group node['icinga2']['group']
            only_if { !zone_objects.empty? }
          end
          zone_dir.run_action :create

          zoned_objects, zoned_templates = separate_zone_resources(zone_objects)

          zoned_ot = template "zone_config_#{resource_name}_#{zone}_#{new_resource.name}" do
            path ::File.join(node['icinga2']['zones_dir'], zone, "#{resource_name}.conf")
            source "object.#{resource_name}.conf.erb"
            cookbook 'icinga2'
            owner node['icinga2']['user']
            group node['icinga2']['group']
            mode 0o640
            variables :objects => zoned_objects
            notifies :reload, 'service[icinga2]'
            only_if { !zoned_objects.length.empty? }
          end

          zoned_te = template "zone_template_#{resource_name}_#{zone}_#{new_resource.name}" do
            path ::File.join(node['icinga2']['zones_dir'], zone, "#{resource_name}_template.conf")
            source "object.#{resource_name}.conf.erb"
            cookbook 'icinga2'
            owner node['icinga2']['user']
            group node['icinga2']['group']
            mode 0o640
            variables :objects => zoned_templates
            notifies :reload, 'service[icinga2]'
            only_if { !zoned_templates.length.empty? }
          end

          zoned_objects_updated = true if zoned_ot.updated? || zoned_te.updated?
        end

        ot.updated? || te.updated? || zoned_objects_updated
      end
    end
  end
end
