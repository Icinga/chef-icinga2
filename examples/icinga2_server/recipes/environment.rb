# frozen_string_literal: true
#
# Cookbook Name:: icinga2_server
# Recipe:: environment
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

icinga2_environment 'AWSDefaultEnvHosts' do
  import node['icinga2']['server']['object']['host']['import']
  environment '_default'
  limit_region true
  enable_cluster_hostgroup true
  enable_application_hostgroup true
  cluster_attribute 'cluster' # update this with your node cluster attribute, e.g. node['cluster_name']
  application_attribute 'application' # udpate this with your node application attribute, e.g. node['application']
end
