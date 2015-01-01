#
# Cookbook Name:: icinga2
# Resource:: notification
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

attribute :import,        :kind_of => String, :default => nil
attribute :host_name,     :kind_of => String, :default => nil
attribute :service_name,  :kind_of => String, :default => nil
attribute :users,         :kind_of => Array, :default => nil
attribute :user_groups,   :kind_of => Array, :default => nil
attribute :times,       :kind_of => Hash, :default => nil
attribute :command,     :kind_of => String, :default => nil
attribute :interval,      :kind_of => [String, Integer], :regex => /^\d+[smhd]$/, :default => nil
attribute :period,        :kind_of => String, :default => nil
attribute :zone,          :kind_of => String, :default => nil
attribute :types,         :kind_of => Array, :default => nil
attribute :states,        :kind_of => Array, :default => nil
attribute :custom_vars,   :kind_of => Hash, :default => nil
attribute :template,      :kind_of => [TrueClass, FalseClass], :default => false
