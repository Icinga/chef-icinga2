#
# Cookbook Name:: icinga2
# Definition:: icinga_feature
#
# Copyright 2008-20013, Opscode, Inc.
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

require 'pp'

define :icinga2_feature, :enable => true, :conf => false do

  if params[:conf]
    template "#{node['icinga2']['conf_dir']}/features-available/#{params[:name]}.conf" do
      cookbook params[:cookbook] if params[:cookbook]
      source "#{params[:name]}.conf.erb"
      owner node['icinga2']['user']
      group node['icinga2']['group']
      mode '0640'
      variables(:params => params)
      notifies :reload, 'service[icinga2]', :delayed
    end
  end

  if params[:enable]
    execute "enable_feature_#{params[:name]}" do
      command "/usr/sbin/icinga2 feature enable #{params[:name]}"
      notifies :reload, 'service[icinga2]', :delayed
      not_if { ::File.symlink?(::File.join(node['icinga2']['features_enabled_dir'], "#{params[:name]}.conf")) }
    end
  else
    execute "disable_feature_#{params[:name]}" do
      command "/usr/sbin/icinga2 feature disable #{params[:name]}"
      notifies :reload, 'service[icinga2]', :delayed
      only_if { ::File.symlink?(::File.join(node['icinga2']['features_enabled_dir'], "#{params[:name]}.conf")) }
    end
  end
end
