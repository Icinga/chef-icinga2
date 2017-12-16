# frozen_string_literal: true
#
# Cookbook Name:: icinga2
# Recipe:: config
#
# Copyright 2014, Virender Khatri
#

# core config
[
  node['icinga2']['conf_dir'],
  ::File.join(node['icinga2']['conf_dir'], 'repository.d'),
  node['icinga2']['conf_d_dir'],
  node['icinga2']['pki_dir'],
  node['icinga2']['scripts_dir'],
  node['icinga2']['zones_dir'],
  node['icinga2']['objects_dir'],
  node['icinga2']['features_enabled_dir'],
  node['icinga2']['features_available_dir'],
  node['icinga2']['custom_plugins_dir'],
].each do |d|
  directory d do
    owner node['icinga2']['user']
    group node['icinga2']['group']
    mode 0o750
  end
end

node['icinga2']['user_defined_objects_dir'].each do |d|
  directory ::File.join(node['icinga2']['conf_dir'], d) do
    owner node['icinga2']['user']
    group node['icinga2']['group']
    mode 0o750
  end
end

[
  node['icinga2']['log_dir'],
  node['icinga2']['run_dir'],
  ::File.join(node['icinga2']['log_dir'], 'compat'),
  ::File.join(node['icinga2']['log_dir'], 'compat', 'archives'),
].each do |d|
  directory d do
    owner node['icinga2']['user']
    group node['icinga2']['cmdgroup']
    recursive true if platform?('windows')
    mode 0o750
  end
end

directory node['icinga2']['cache_dir'] do
  owner node['icinga2']['user']
  group node['icinga2']['user']
  recursive true if platform?('windows')
  mode 0o750
end

unless platform?('windows')
  # icinga2 logrotate
  template '/etc/logrotate.d/icinga2' do
    source 'icinga2.logrotate.erb'
    owner 'root'
    group 'root'
    mode 0o644
    variables(:log_dir => node['icinga2']['log_dir'], :user => node['icinga2']['user'], :group => node['icinga2']['group'])
  end
end

# icinga2.conf
template ::File.join(node['icinga2']['conf_dir'], 'icinga2.conf') do
  source 'icinga2.conf.erb'
  owner node['icinga2']['user']
  group node['icinga2']['group']
  mode 0o640
  variables(
    :include_itl => node['icinga2']['include_itl'],
    :disable_repository_d => node['icinga2']['disable_repository_d'],
    :disable_conf_d => node['icinga2']['disable_conf_d'],
    :objects_d => node['icinga2']['objects_d'],
    :user_defined_objects_dir => node['icinga2']['user_defined_objects_dir']
  )
  notifies platform?('windows') ? :restart : :reload, 'service[icinga2]', :delayed
end

unless platform?('windows')
  # icinga2 service config file
  template node['icinga2']['service_config_file'] do
    source 'icinga2.service.config.erb'
    owner 'root'
    group 'root'
    mode 0o640
    variables(
      :log_dir => node['icinga2']['log_dir'],
      :conf_dir => node['icinga2']['conf_dir'],
      :user => node['icinga2']['user'],
      :group => node['icinga2']['group'],
      :cmdgroup => node['icinga2']['cmdgroup']
    )
    notifies platform?('windows') ? :restart : :reload, 'service[icinga2]', :delayed
  end

  # icinga2 service init config file
  template ::File.join(node['icinga2']['conf_dir'], 'init.conf') do
    source 'icinga2.init.conf.erb'
    owner node['icinga2']['user']
    group node['icinga2']['group']
    mode 0o640
    variables(
      :user => node['icinga2']['user'],
      :group => node['icinga2']['group']
    )
    notifies platform?('windows') ? :restart : :reload, 'service[icinga2]', :delayed
  end
end

# icinga2 constants config file
template ::File.join(node['icinga2']['conf_dir'], 'constants.conf') do
  source 'icinga2.constants.conf.erb'
  owner node['icinga2']['user']
  group node['icinga2']['group']
  mode 0o640
  variables(
    :options => node['icinga2']['constants']
  )
  notifies platform?('windows') ? :restart : :reload, 'service[icinga2]', :delayed
end

# server config

# mail-service-notification command
template ::File.join(node['icinga2']['scripts_dir'], 'mail-service-notification.sh') do
  cookbook node['icinga2']['cookbook']
  source 'mail-service-notification.sh.erb'
  owner node['icinga2']['user']
  group node['icinga2']['group']
  mode 0o755
end

# mail-host-notification command
template ::File.join(node['icinga2']['scripts_dir'], 'mail-host-notification.sh') do
  cookbook node['icinga2']['cookbook']
  source 'mail-host-notification.sh.erb'
  owner node['icinga2']['user']
  group node['icinga2']['group']
  mode 0o755
end

# icinga2 service user limit
user_ulimit node['icinga2']['user'] do
  filehandle_limit node['icinga2']['limits']['nofile']
  process_limit node['icinga2']['limits']['nproc']
  memory_limit node['icinga2']['limits']['memlock']
end
