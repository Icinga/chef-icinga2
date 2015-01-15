#
# Cookbook Name:: icinga2
# Resource:: idomysqlconnection
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

attribute :library,  :kind_of => String, :default => 'db_ido_mysql'
attribute :host,  :kind_of => String, :default => 'localhost'
attribute :port,  :kind_of => Integer, :default => '3306'
attribute :user,  :kind_of => String, :default => 'icinga'
attribute :password,  :kind_of => String, :default => 'icinga'
attribute :database,  :kind_of => String, :default => 'icinga'
attribute :table_prefix,  :kind_of => String, :default => 'icinga_'
attribute :instance_name,  :kind_of => String, :default => 'default'
attribute :instance_description,  :kind_of => String, :default => nil
attribute :enable_ha,  :kind_of => [TrueClass, FalseClass], :default => nil
attribute :failover_timeout,  :kind_of => [String, Integer], :default => '60s'
attribute :cleanup,  :kind_of => Hash, :default => nil
attribute :categories,  :kind_of => Array, :default => nil
