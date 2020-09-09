# frozen_string_literal: true
#
# Cookbook:: icinga2_server
# Recipe:: default
#
# Copyright:: 2014, Virender Khatri
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

include_recipe 'icinga2_server::usergroup'
include_recipe 'icinga2_server::user'
include_recipe 'icinga2_server::servicegroup'
include_recipe 'icinga2_server::applyservice'
# include_recipe 'icinga2_server::notificationcommand'
include_recipe 'icinga2_server::notification'
include_recipe 'icinga2_server::applynotification'
include_recipe 'icinga2_server::environment'
