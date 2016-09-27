# frozen_string_literal: true
#
# Cookbook Name:: icinga2
# Recipe:: client
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

include_recipe 'icinga2::attributes'

include_recipe 'icinga2::client_os_packages'

# install icinga2 packages
include_recipe 'icinga2::core_install'

# configure icinga2 core files / directories
include_recipe 'icinga2::core_config'

include_recipe 'icinga2::service'
