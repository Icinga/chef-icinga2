#
# Cookbook Name:: icinga2
# Resource:: apilistener
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

attribute :cert_path,       :required => true, :kind_of => String, :default => nil
attribute :key_path,        :required => true, :kind_of => String, :default => nil
attribute :ca_path,         :required => true, :kind_of => String, :default => nil
attribute :crl_path,        :kind_of => String, :default => nil
attribute :bind_host,       :kind_of => String, :default => nil
attribute :bind_port,       :kind_of => String, :default => nil
attribute :ticket_salt,     :kind_of => String, :default => 'TicketSalt'
attribute :accept_config,   :kind_of => [TrueClass, FalseClass], :default => nil
attribute :accept_commands, :kind_of => [TrueClass, FalseClass], :default => nil
