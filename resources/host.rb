#
# Cookbook Name:: icinga2
# Resource:: host
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

attribute :display_name,  :kind_of => String, :default => nil
attribute :import,        :kind_of => String, :default => nil
attribute :address,  :kind_of => String, :default => nil
attribute :address6,  :kind_of => String, :default => nil
attribute :groups,        :kind_of => Array, :default => nil
attribute :check_command, :kind_of => String, :default => nil
attribute :max_check_attempts,  :kind_of => Integer, :default => nil
attribute :check_period,  :kind_of => String, :default => nil
attribute :check_interval,      :kind_of => [String, Integer], :regex => /^\d+[smhd]$/, :default => nil
attribute :retry_interval,      :kind_of => [String, Integer], :regex => /^\d+[smhd]$/, :default => nil
attribute :enable_notifications,  :kind_of => [TrueClass, FalseClass], :default => nil
attribute :enable_active_checks,  :kind_of => [TrueClass, FalseClass], :default => nil
attribute :enable_passive_checks, :kind_of => [TrueClass, FalseClass], :default => nil
attribute :enable_event_handler,  :kind_of => [TrueClass, FalseClass], :default => nil
attribute :enable_flapping,       :kind_of => [TrueClass, FalseClass], :default => nil
attribute :enable_perfdata,       :kind_of => [TrueClass, FalseClass], :default => nil
attribute :event_command,         :kind_of => String, :default => nil
attribute :flapping_threshold,    :kind_of => String, :default => nil
attribute :volatile,      :kind_of => [TrueClass, FalseClass], :default => nil
attribute :zone,          :kind_of => String, :default => nil
attribute :command_endpoint,      :kind_of => String, :default => nil
attribute :notes,         :kind_of => String, :default => nil
attribute :notes_url,     :kind_of => String, :default => nil
attribute :action_url,    :kind_of => String, :default => nil
attribute :icon_image,    :kind_of => String, :default => nil
attribute :icon_image_alt,  :kind_of => String, :default => nil
attribute :custom_vars,     :kind_of => Hash, :default => nil
attribute :template,        :kind_of => [TrueClass, FalseClass], :default => false
