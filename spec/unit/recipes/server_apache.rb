# frozen_string_literal: true
require 'spec_helper'

describe 'icinga2::server_apache' do
  before do
    stub_command('/usr/sbin/httpd -t').and_return(true)
    stub_command('/usr/sbin/apache2 -t').and_return(true)
    stub_command('which php').and_return(true)
  end

  shared_context 'rhel_family' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '6.8') do |node|
        node.automatic['platform_family'] = 'rhel'
        node.set['icinga2']['classic_ui']['enable'] = true
        node.set['icinga2']['web2']['enable'] = true
        node.set['icinga2']['ignore_version'] = true
      end.converge(described_recipe)
    end

    it 'creates an icinga2-classicui config file for httpd' do
      expect(chef_run).to create_template('/etc/httpd/conf-available/icinga2-classic-ui.conf').with(
        source: 'apache.vhost.icinga2_classic_ui.conf.rhel.erb',
        owner: 'apache',
        group: 'apache'
      )
    end

    it 'creates an icinga2-web2 config file for httpd' do
      expect(chef_run).to create_template('/etc/httpd/conf-available/icinga2-web2.conf').with(
        source: 'apache.vhost.icinga2_web2.erb',
        owner: 'apache',
        group: 'apache'
      )
    end

    it 'defines an icinga group' do
      group = chef_run.group('icinga')
      expect(group).to do_nothing
    end

    it 'modifies a manage_members_icinga group' do
      group = chef_run.group('manage_members_icinga')
      expect(group).to do_nothing
    end
  end

  context 'rhel' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '6.8') do |node|
        node.automatic['platform_family'] = 'rhel'
        node.set['icinga2']['classic_ui']['enable'] = true
        node.set['icinga2']['web2']['enable'] = true
        node.set['icinga2']['ignore_version'] = true
      end.converge(described_recipe)
    end

    include_context 'rhel_family'
  end

  context 'amazon' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'amazon', version: '2017.03') do |node|
        node.automatic['platform_family'] = 'amazon'
        node.set['icinga2']['classic_ui']['enable'] = true
        node.set['icinga2']['web2']['enable'] = true
        node.set['icinga2']['ignore_version'] = true
      end.converge(described_recipe)
    end

    include_context 'rhel_family'
  end

  context 'ubuntu' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04') do |node|
        node.automatic['platform_family'] = 'debian'
        node.automatic['lsb']['codename'] = 'trusty'
        node.set['icinga2']['classic_ui']['enable'] = true
        node.set['icinga2']['ignore_version'] = true
        node.set['icinga2']['web2']['enable'] = true
        node.set['platform'] = 'ubuntu'
      end.converge(described_recipe)
    end

    it 'install package libapache2-mod-php5' do
      expect(chef_run).to install_package('libapache2-mod-php5')
    end

    it 'creates an icinga2-classicui config file for apache2' do
      expect(chef_run).to create_template('/etc/apache2/conf-available/icinga2-classicui.conf').with(
        source: 'apache.vhost.icinga2_classic_ui.conf.debian.erb',
        owner: 'www-data',
        group: 'www-data'
      )
    end

    it 'creates an icinga2-web2 config file for apache2' do
      expect(chef_run).to create_template('/etc/apache2/conf-available/icinga2-web2.conf').with(
        source: 'apache.vhost.icinga2_web2.erb',
        owner: 'www-data',
        group: 'www-data'
      )
    end

    it 'creates a nagios user' do
      expect(chef_run).to create_user('nagios')
    end

    it 'creates a nagios group' do
      expect(chef_run).to create_group('nagios')
    end

    it 'modifies a manage_members_nagios group' do
      expect(chef_run).to modify_group('manage_members_nagios')
    end
  end
end
