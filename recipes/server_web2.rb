#
# Cookbook Name:: icinga2
# Recipe:: server_web2
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

directory node['icinga2']['web2']['conf_dir'] do
  owner node[node['icinga2']['web_engine']]['user']
  group node[node['icinga2']['web_engine']]['group']
  mode '02770'
end

directory node['icinga2']['web2']['web_root'] do
  owner node[node['icinga2']['web_engine']]['user']
  group node[node['icinga2']['web_engine']]['group']
  mode '0775'
end

directory node['icinga2']['web2']['log_dir'] do
  owner node[node['icinga2']['web_engine']]['user']
  group node[node['icinga2']['web_engine']]['group']
  mode '0775'
end

# setup token
unless node['icinga2']['web2'].key?('setup_token')
  require 'securerandom'
  node.set['icinga2']['web2']['setup_token'] = SecureRandom.base64(12)
end

file ::File.join(node['icinga2']['web2']['conf_dir'], 'setup.token') do
  content node['icinga2']['web2']['setup_token']
  owner node[node['icinga2']['web_engine']]['user']
  group node[node['icinga2']['web_engine']]['group']
  mode 0o660
end

git node['icinga2']['web2']['web_root'] do
  repository node['icinga2']['web2']['source_url']
  revision node['icinga2']['web2']['version']
  user node[node['icinga2']['web_engine']]['user']
  group node[node['icinga2']['web_engine']]['group']
end
