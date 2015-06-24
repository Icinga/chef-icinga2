#
# Cookbook Name:: icinga2
# Resource:: environment
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

actions :create, :delete

default_action :create

attribute :environment,     :kind_of => String, :required => true, :default => nil
attribute :search_pattern,  :kind_of => String, :default => nil
attribute :env_resources,   :kind_of => Hash, :default => nil
attribute :cookbook, :kind_of => String, :default => 'icinga2'
attribute :template, :kind_of => String, :default => 'object.environment.conf.erb'

# create host group for node clusters, applications, roles and recipes
attribute :enable_cluster_hostgroup,      :kind_of => [TrueClass, FalseClass], :default => node['icinga2']['enable_cluster_hostgroup']
attribute :cluster_attribute,             :kind_of => String, :default => node['icinga2']['cluster_attribute']
attribute :enable_application_hostgroup,  :kind_of => [TrueClass, FalseClass], :default => node['icinga2']['enable_application_hostgroup']
attribute :application_attribute,         :kind_of => String, :default => node['icinga2']['application_attribute']
attribute :enable_role_hostgroup,         :kind_of => [TrueClass, FalseClass], :default => node['icinga2']['enable_role_hostgroup']

attribute :use_fqdn_resolv,     :kind_of => [TrueClass, FalseClass], :default => node['icinga2']['use_fqdn_resolv']
attribute :failover_fqdn_address, :kind_of => [TrueClass, FalseClass], :default => node['icinga2']['failover_fqdn_address']
attribute :ignore_node_error,   :kind_of => [TrueClass, FalseClass], :default => node['icinga2']['ignore_node_error']
attribute :ignore_resolv_error, :kind_of => [TrueClass, FalseClass], :default => node['icinga2']['ignore_resolv_error']
attribute :exclude_recipes,     :kind_of => Array, :default => []
attribute :exclude_roles,       :kind_of => Array, :default => []
attribute :env_custom_vars,     :kind_of => Hash, :default => {}
attribute :limit_region,        :kind_of => [TrueClass, FalseClass], :default => node['icinga2']['limit_region']
attribute :server_region,       :kind_of => String, :default => nil
attribute :host_display_name_attr,        :kind_of => String, :equal_to => %w(fqdn hostname name), :default => node['icinga2']['host_display_name_attr']

attribute :add_cloud_custom_vars,         :kind_of => [TrueClass, FalseClass], :default => node['icinga2']['add_cloud_custom_vars']
attribute :env_filter_node_vars,          :kind_of => Hash, :default => {}

# environment host default attributes
attribute :import,              :kind_of => String, :default => nil
attribute :check_command,       :kind_of => String, :default => nil
attribute :max_check_attempts,  :kind_of => Integer, :default => nil
attribute :check_period,    :kind_of => String, :default => nil
attribute :check_interval,  :kind_of => [String, Integer], :regex => /^\d+[smhd]$/, :default => nil
attribute :retry_interval,  :kind_of => [String, Integer], :regex => /^\d+[smhd]$/, :default => nil
attribute :enable_notifications,  :kind_of => [TrueClass, FalseClass], :default => nil
attribute :enable_active_checks,  :kind_of => [TrueClass, FalseClass], :default => nil
attribute :enable_passive_checks, :kind_of => [TrueClass, FalseClass], :default => nil
attribute :enable_event_handler,  :kind_of => [TrueClass, FalseClass], :default => nil
attribute :enable_flapping,       :kind_of => [TrueClass, FalseClass], :default => nil
attribute :enable_perfdata,       :kind_of => [TrueClass, FalseClass], :default => nil
attribute :event_command,         :kind_of => String, :default => nil
attribute :flapping_threshold,    :kind_of => String, :default => nil
attribute :volatile,              :kind_of => [TrueClass, FalseClass], :default => nil
attribute :zone,                  :kind_of => String, :default => nil
attribute :command_endpoint,      :kind_of => String, :default => nil
attribute :notes,           :kind_of => String, :default => nil
attribute :notes_url,       :kind_of => String, :default => nil
attribute :action_url,      :kind_of => String, :default => nil
attribute :icon_image,      :kind_of => String, :default => nil
attribute :icon_image_alt,  :kind_of => String, :default => nil
