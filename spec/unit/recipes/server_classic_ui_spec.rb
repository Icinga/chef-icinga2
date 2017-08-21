# frozen_string_literal: true
require 'spec_helper'

describe 'icinga2::server_classic_ui' do
  # before do
  #  stub_command("/usr/sbin/httpd -t").and_return(true)
  #  stub_command("/usr/sbin/apache2 -t").and_return(true)
  #  stub_command("which php").and_return(true)
  # end

  shared_context 'rhel_family' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '6.8') do |node|
        node.automatic['platform_family'] = 'rhel'
        node.override['icinga2']['classic_ui']['enable'] = true
        node.override['icinga2']['ignore_version'] = true
      end.converge(described_recipe)
    end

    it 'install package icinga2-classicui-config' do
      expect(chef_run).to install_package('icinga2-classicui-config')
    end

    it 'install package icinga-gui' do
      expect(chef_run).to install_package('icinga-gui')
    end

    %w(/var/log/icinga /var/log/icinga/gui).each do |d|
      it "creates directory #{d}" do
        expect(chef_run).to create_directory(d).with(
          owner: 'icinga',
          group: 'icingacmd'
        )
      end
    end

    %w(cgi.cfg resources.cfg).each do |c|
      it "configure icinga2 apache conf file /etc/icinga/#{c}" do
        expect(chef_run).to create_template("/etc/icinga/#{c}").with(
          source: "icinga2.#{c}.erb",
          owner: 'root',
          group: 'root',
          mode: 0o644
        )
      end
    end

    it 'configure icinga2 apache conf file /etc/icinga/passwd' do
      expect(chef_run).to create_template('/etc/icinga/passwd').with(
        source: 'icinga2.passwd.erb',
        owner: 'root',
        group: 'apache',
        mode: 0o640
      )
    end
  end

  context 'rhel' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '6.8') do |node|
        node.automatic['platform_family'] = 'rhel'
        node.override['icinga2']['classic_ui']['enable'] = true
        node.override['icinga2']['ignore_version'] = true
      end.converge(described_recipe)
    end

    include_context 'rhel_family'
  end

  context 'amazon' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'amazon', version: '2017.03') do |node|
        node.automatic['platform_family'] = 'amazon'
        node.override['icinga2']['classic_ui']['enable'] = true
        node.override['icinga2']['ignore_version'] = true
      end.converge(described_recipe)
    end

    include_context 'rhel_family'
  end

  context 'ubuntu' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04') do |node|
        node.automatic['platform_family'] = 'debian'
        node.override['icinga2']['classic_ui']['enable'] = true
        node.override['icinga2']['ignore_version'] = true
      end.converge(described_recipe)
    end

    it 'install package icinga2-classicui' do
      expect(chef_run).to install_package('icinga2-classicui')
    end

    %w(/var/log/icinga /var/log/icinga/gui).each do |d|
      it "creates directory #{d}" do
        expect(chef_run).to create_directory(d).with(
          owner: 'nagios',
          group: 'nagios'
        )
      end
    end

    %w(cgi.cfg resources.cfg).each do |c|
      it "configure icinga2 apache conf file /etc/icinga2-classicui/#{c}" do
        expect(chef_run).to create_template("/etc/icinga2-classicui/#{c}").with(
          source: "icinga2.#{c}.erb",
          owner: 'root',
          group: 'root',
          mode: 0o644
        )
      end
    end

    it 'configure icinga2 apache conf file /etc/icinga2-classicui/htpasswd.users' do
      expect(chef_run).to create_template('/etc/icinga2-classicui/htpasswd.users').with(
        source: 'icinga2.passwd.erb',
        owner: 'root',
        group: 'www-data',
        mode: 0o640
      )
    end
  end
end
