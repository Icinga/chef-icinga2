# frozen_string_literal: true
#
# Cookbook Name:: icinga2
# Recipe:: search
#
# Copyright 2014, Virender Khatri
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef'
require 'chef/node'
require 'chef/rest'
require 'chef/role'
require 'chef/environment'
require 'chef/data_bag'
require 'chef/data_bag_item'
require 'resolv'

module Icinga2
  # fetch node information into Hash
  class Search
    attr_accessor :query, :environment, :enable_cluster_hostgroup, :enable_role_hostgroup, :cluster_attribute,
                  :enable_application_hostgroup, :application_attribute, :ignore_node_error,
                  :ignore_resolv_error, :exclude_recipes, :exclude_roles, :env_custom_vars,
                  :limit_region, :server_region, :search_pattern, :use_fqdn_resolv,
                  :add_cloud_custom_vars, :env_skip_node_vars, :add_node_vars,
                  :env_filter_node_vars, :failover_fqdn_address, :add_inet_custom_vars

    def initialize(options = {})
      @query = options
      @environment = options[:environment]
      @enable_cluster_hostgroup = options[:enable_cluster_hostgroup]
      @cluster_attribute = options[:cluster_attribute]
      @enable_application_hostgroup = options[:enable_application_hostgroup]
      @enable_role_hostgroup = options[:enable_role_hostgroup]
      @application_attribute = options[:application_attribute]
      @ignore_node_error = options[:ignore_node_error]
      @ignore_resolv_error = options[:ignore_resolv_error]
      @exclude_recipes = options[:exclude_recipes]
      @exclude_roles = options[:exclude_roles]
      @env_custom_vars = options[:env_custom_vars]
      @limit_region = options[:limit_region]
      @server_region = options[:server_region]
      @search_pattern = options[:search_pattern]
      @use_fqdn_resolv = options[:use_fqdn_resolv]
      @add_cloud_custom_vars = options[:add_cloud_custom_vars]
      @add_inet_custom_vars = options[:add_inet_custom_vars]
      @add_node_vars = options[:add_node_vars]
      @env_filter_node_vars = options[:env_filter_node_vars]
      @env_skip_node_vars = options[:env_skip_node_vars]
      @failover_fqdn_address = options[:failover_fqdn_address]
    end

    def fqdn_resolv(fqdn)
      begin
        address = Resolv.getaddress(fqdn)
      rescue
        address = false
      end
      address
    end

    def variable_check(var)
      var.to_s.empty? ? false : true
    end

    def environment_resources
      s = Chef::Search::Query.new
      results = s.search('node', search_pattern)[0]
      convert_resources(results)
    end

    def convert_resources(results)
      nodes = {}
      clusters = []
      applications = []
      roles = []
      recipes = []
      results.each do |node|
        # skip node if set not to monitor
        if node['monitoring_off'] == true
          Chef::Log.warn("#{node.name} is set to turn off the monitoring, node ignored")
          next
        end

        node_hash = convert_node(node)
        break_loop = false

        # match node attributes to given env attributes
        env_filter_node_vars.each do |k, v|
          node_value = node_hash[k.to_s]
          if (v.is_a?(String) && v != node_value) || (v.is_a?(Regexp) && node_value !~ v) || (v.is_a?(Array) && !v.include?(node_value))
            Chef::Log.warn("node#{k}=#{node_hash[k]} does not match with env_filter_node_vars[#{k}]=#{env_filter_node_vars[k]}, node ignored")
            break_loop = true
          end
          break if break_loop
        end

        next if break_loop

        # skip node attributes to given env attributes
        env_skip_node_vars.each do |k, v|
          node_value = node_hash[k.to_s]
          if (v.is_a?(String) && v == node_value) || (v.is_a?(Regexp) && node_value =~ v) || (v.is_a?(Array) && v.include?(node_value))
            Chef::Log.warn("node[#{k}]=#{node_value} matches with env_skip_node_vars[#{k}]=#{v.inspect}, node #{node.name} ignored")
            break_loop = true
          end
          break if break_loop
        end

        next if break_loop

        # check server region with node region
        if limit_region && server_region
          # skip region check if node_region value is not present
          if variable_check(node_hash['node_region'])
            # skip node if server and node region does not match
            next unless server_region == node_hash['node_region']
          end
        end

        # skip node if unable to resolv node fqdn
        unless node_hash['address']
          unless ignore_resolv_error
            Chef::Log.warn("#{node_hash['name']} unable to resolv fqdn, node ignored")
            next
          end
        end

        # skip node if recipe/role to be excluded
        # code here

        begin
          # check node attributes
          validate_node(node_hash)
        rescue => error
          # ignore node if unable to determine all attributes
          unless ignore_node_error
            Chef::Log.warn("#{error.message}, node ignored")
            next
          end
        end

        # collect node roles / recipes
        roles += node_hash['roles']
        recipes += node_hash['recipes']

        if node_hash['custom_vars'].key?('hostgroups')
          if node_hash['custom_vars']['hostgroups'].is_a?(Array)
            node_hash['custom_vars']['hostgroups'].push node_hash['chef_environment']
          else
            raise "node 'hostgroups' must be defined as an Array of HostGroup name (node['icinga2']['client']['custom_vars']['hostgroups'])"
          end
        else
          node_hash['custom_vars']['hostgroups'] = [node_hash['chef_environment']]
        end

        # collect nodes roles
        if enable_role_hostgroup
          node_hash['custom_vars']['hostgroups'].push(*(node_hash['roles'].map { |r| node_hash['chef_environment'] + '-' + r }))
        end

        # collect nodes cluster
        if variable_check(node_hash[cluster_attribute]) && enable_cluster_hostgroup
          clusters.push node_hash[cluster_attribute]
          node_hash['custom_vars']['hostgroups'].push node_hash['chef_environment'] + '-' + node_hash[cluster_attribute]
        end

        # collect node application types
        if node_hash[application_attribute].is_a?(Array) && enable_application_hostgroup
          applications += node_hash[application_attribute].uniq
          node_hash[application_attribute].uniq.each do |a|
            node_hash['custom_vars']['hostgroups'].push node_hash['chef_environment'] + '-' + a if variable_check(a)
          end
        elsif node_hash[application_attribute].is_a?(String) && variable_check(node_hash[application_attribute]) && enable_application_hostgroup
          applications.push node_hash[application_attribute]
          node_hash['custom_vars']['hostgroups'].push node_hash['chef_environment'] + '-' + node_hash[application_attribute]
        end
        node_hash['custom_vars']['hostgroups'].uniq!
        # need to verify whether we need hostgroups for node
        # node_hash['hostgroups'] = node_hash['custom_vars']['hostgroups']

        nodes[node_hash['fqdn']] = node_hash
      end
      { 'nodes' => nodes, 'recipes' => recipes.sort.uniq, 'roles' => roles.sort.uniq, 'clusters' => clusters.sort.uniq, 'applications' => applications.sort.uniq }
    end

    def convert_node(node)
      # prepare Node Hash object
      node_hash = {}
      node_hash['name'] = node.name
      if use_fqdn_resolv
        # lookup ip address from node fqdn
        node_hash['address'] = fqdn_resolv(node_hash['name'])
        node_hash['address'] = node['ipaddress'] if failover_fqdn_address && !node_hash['address']
      else
        node_hash['address'] = node['ipaddress']
      end

      node_hash['address6'] = node['ip6address']
      node_hash['chef_environment'] = node.chef_environment
      node_hash['environment'] = node.chef_environment
      node_hash['run_list'] = node.run_list
      node_hash['recipes'] = !node.run_list.nil? ? node.run_list.recipes : []
      node_hash['roles'] = !node.run_list.nil? ? node.run_list.roles : []
      node_hash['fqdn'] = node['fqdn']
      node_hash['hostname'] = node['hostname']
      node_hash['kernel_machine'] = !node['kernel'].nil? ? node['kernel']['machine'] : nil
      node_hash['kernel_os'] = !node['kernel'].nil? ? node['kernel']['os'] : nil
      node_hash['os'] = node['os']
      node_hash['platform'] = node['platform']
      node_hash['platform_version'] = node['platform_version']
      node_hash['tags'] = node['tags']
      node_hash['disks'] = node['filesystem'].map { |d, o| d if d.to_s =~ %r{^/dev} && o['fs_type'] != 'swap' && o.key?('mount') }.compact if node['filesystem']

      node_hash['custom_vars'] = node_custom_vars(node['icinga2'])
      # chef client last run
      # node_hash['last_known_run'] = Time.at(node.automatic['ohai_time'])

      # not required, keeping it for the moment
      node_hash['custom_vars']['tags'] = node_hash['tags']

      # https://github.com/Icinga/icinga2/blob/master/doc/3-monitoring-basics.md
      node_hash['custom_vars']['disks'] = { 'mounts' => { 'disk_partitions' => node_hash['disks'] } }

      # remote_client for remote checks
      node_hash['custom_vars']['remote_client'] = node['fqdn']

      # add default chef attributes
      node_hash['custom_vars']['platform'] = node_hash['platform']
      node_hash['custom_vars']['platform_version'] = node_hash['platform_version']
      # if failed to fetch cpu info, set it to 0
      node_hash['custom_vars']['cpu'] = !node['cpu'].nil? ? node['cpu']['total'] : 0
      # if failed to fetch memory info, set it to 0MB
      node_hash['custom_vars']['memory'] = !node['memory'].nil? && !node['memory']['total'].nil? ? (node['memory']['total'].gsub(/\D/, '').to_i / 1024).to_s + 'MB' : '0MB'
      node_hash['custom_vars']['environment'] = node_hash['chef_environment']
      node_hash['custom_vars']['run_list'] = node_hash['run_list'].to_s
      # add inet ip address custom vars
      if add_inet_custom_vars && !node['network'].nil?
        node['network']['interfaces'].each do |k, v|
          next if k == 'lo'
          v['addresses'].each do |i, o|
            next if o['family'] !~ /inet/
            node_hash['custom_vars']["address_#{o['family']}_#{k}"] = i
          end
        end
      end

      if enable_cluster_hostgroup && cluster_attribute
        node_hash[cluster_attribute] = node[cluster_attribute.to_sym].to_s
        node_hash['custom_vars'][cluster_attribute] = node_hash[cluster_attribute].to_s
      end

      if enable_application_hostgroup && application_attribute
        node_hash[application_attribute] = node[application_attribute] || []
        node_hash['custom_vars'][application_attribute] = node_hash[application_attribute] || []
      end

      if add_cloud_custom_vars
        if node.key?('ec2')
          node_hash['node_region'] = node['ec2']['placement_availability_zone'].chop
          node_hash['custom_vars']['node_id'] = node['ec2']['instance_id']
          node_hash['custom_vars']['node_type'] = node['ec2']['instance_type']
          node_hash['custom_vars']['node_zone'] = node['ec2']['placement_availability_zone']
          node_hash['custom_vars']['node_region'] = node['ec2']['placement_availability_zone'].chop
          node_hash['custom_vars']['node_security_groups'] = node['ec2']['security_groups'].sort.uniq if node['ec2']['security_groups'].is_a?(Array)
          node_hash['custom_vars']['node_wan_address'] = node['ec2']['public_ipv4'].to_s

          node['ec2']['network_interfaces_macs'].each do |_net, net_options|
            node_hash['custom_vars']['node_vpc_cidr'] = net_options['vpc_ipv4_cidr_block'].to_s
            break
          end
        else
          # check for other cloud providers
          node_hash['node_region'] = nil
        end
      end

      # add node custom vars from environment lwrp
      env_custom_vars.each do |k, v|
        node_hash['custom_vars'][k.to_s] = v if variable_check(k)
      end

      # add node attributes
      # there might be a better way to do this
      add_node_vars.each do |k, v|
        raise "expecting an Array of keys for key '#{k}' in resource attribute :add_node_vars" unless v.is_a?(Array)
        node_hash['custom_vars'][k.to_s] = hash_key_value(node, v)
      end

      node_hash
    end

    def node_custom_vars(vars)
      custom_vars = {}
      # add icinga2 host custom vars from node custom_vars
      if vars && vars.key?('client')
        if vars['client'].key?('custom_vars') && vars['client']['custom_vars'].is_a?(Hash)
          custom_vars = vars['client']['custom_vars'].to_hash
        end
      end
      custom_vars
    end

    def validate_node(node_hash)
      raise ArgumentError, "#{node_hash['name']} missing 'chef_environment'" unless node_hash['chef_environment']
      raise ArgumentError, "#{node_hash['name']} missing 'fqdn'" unless node_hash['fqdn']
      raise ArgumentError, "#{node_hash['name']} missing 'hostname'" unless node_hash['hostname']
    end

    def hash_key_value(hash, keys = [])
      value = nil
      keys.each do |key|
        if hash.key?(key)
          hash = hash[key]
          value = hash
        else
          value = nil
          break
        end
      end
      value
    end
  end
end
