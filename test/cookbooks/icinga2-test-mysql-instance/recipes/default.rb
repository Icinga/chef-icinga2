mysql2_chef_gem 'default' do
  action :install
end

mysql_version = case node['lsb']['codename']
                when 'trusty', 'jessie', 'wheezy' then '5.5'
                else '5.7'
                end

if node['platform'] == 'centos'
  yum_repository 'mysql57-community' do
    baseurl node['yum']['mysql57-community']['baseurl'] unless node['yum']['mysql57-community']['baseurl'].nil?
    mirrorlist node['yum']['mysql57-community']['mirrorlist'] unless node['yum']['mysql57-community']['mirrorlist'].nil?
    description node['yum']['mysql57-community']['description'] unless node['yum']['mysql57-community']['description'].nil?
    failovermethod node['yum']['mysql57-community']['failovermethod'] unless node['yum']['mysql57-community']['failovermethod'].nil?
    enabled true
    gpgcheck true
    gpgkey node['yum']['mysql57-community']['gpgkey'] unless node['yum']['mysql57-community']['gpgkey'].nil?
  end
end

mysql_service 'test-mysql' do
  port '3306'
  version mysql_version
  initial_root_password 'Xvtd7I9Hp2'
  action [:create, :start]
end

mysql_connection_info = {
  :host     => '127.0.0.1',
  :username => 'root',
  :password => 'Xvtd7I9Hp2',
}

mysql_database 'icinga' do
  connection mysql_connection_info
  action :create
end

mysql_database_user 'icinga' do
  connection mysql_connection_info
  password 'X2BM0WKnN'
  database_name 'icinga'
  privileges [:all]
  action [:create, :grant]
end