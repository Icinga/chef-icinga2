#
# Cookbook Name:: icinga2
# Resource:: timeperiod
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
attribute :import,        :kind_of => String, :default => nil # default value could be set to 'legacy-timeperiod'
attribute :zone,          :kind_of => String, :default => nil
attribute :ranges,        :kind_of => Hash,   :default => {}
attribute :template,      :kind_of => [TrueClass, FalseClass], :default => false
