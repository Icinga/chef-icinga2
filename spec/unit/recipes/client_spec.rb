# frozen_string_literal: true
require 'spec_helper'

describe 'icinga2::client' do
  shared_examples_for 'icinga' do
    context 'all_platforms' do
      %w(attributes client_os_packages core_install core_config service).each do |r|
        it "include recipe icinga2::#{r}" do
          expect(chef_run).to include_recipe("icinga2::#{r}")
        end
      end

      it 'install package icinga2' do
        expect(chef_run).to install_package('icinga2')
      end

      it 'configure logrotate for icinga2' do
        expect(chef_run).to create_template('/etc/logrotate.d/icinga2').with(
          source: 'icinga2.logrotate.erb',
          owner: 'root',
          group: 'root',
          mode: 0o644
        )
      end

      it 'enable icinga2 service' do
        expect(chef_run).to enable_service('icinga2')
      end

      it 'notifies icinga2 service' do
        expect(chef_run).to run_ruby_block('delayed_icinga2_service_start')
        expect(chef_run.ruby_block('delayed_icinga2_service_start')).to notify('service[icinga2]').to(:start).delayed
      end
    end
  end

  shared_context 'rhel_family' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '6.8') do |node|
        node.automatic['platform_family'] = 'rhel'
      end.converge(described_recipe)
    end

    include_examples 'icinga'

    %w(/var/log/icinga2 /var/run/icinga2 /var/cache/icinga2 /var/log/icinga2/compat /var/log/icinga2/compat/archives).each do |d|
      it "creates directory #{d}" do
        expect(chef_run).to create_directory(d).with(
          owner: 'icinga',
          group: 'icingacmd'
        )
      end
    end

    %w(/etc/icinga2 /etc/icinga2/conf.d /etc/icinga2/objects.d /etc/icinga2/pki /etc/icinga2/scripts /etc/icinga2/zones.d /etc/icinga2/features-enabled /etc/icinga2/features-available /opt/icinga2_custom_plugins /etc/icinga2/user_defined_objects).each do |d|
      it "creates directory #{d}" do
        expect(chef_run).to create_directory(d).with(
          owner: 'icinga',
          group: 'icinga'
        )
      end
    end

    it 'adds icinga2 repository' do
      expect(chef_run).to create_yum_repository('icinga2')
    end

    %w(gcc gcc-c++ glibc glibc-common mailx).each do |p|
      it "install package #{p}" do
        expect(chef_run).to install_package(p)
      end
    end

    it 'configure icinga2' do
      expect(chef_run).to create_template('/etc/icinga2/icinga2.conf').with(
        source: 'icinga2.conf.erb',
        owner: 'icinga',
        group: 'icinga',
        mode: 0o644
      )
    end

    %w(constants.conf init.conf).each do |c|
      it "configure #{c}" do
        expect(chef_run).to create_template("/etc/icinga2/#{c}").with(
          source: "icinga2.#{c}.erb",
          owner: 'icinga',
          group: 'icinga',
          mode: 0o644
        )
      end
    end

    it 'configure icinga2 environment file' do
      expect(chef_run).to create_template('/etc/sysconfig/icinga2').with(
        source: 'icinga2.service.config.erb',
        owner: 'root',
        group: 'root',
        mode: 0o644
      )
    end
  end

  context 'amazon' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'amazon', version: '2017-03') do |node|
        node.automatic['platform_family'] = 'amazon'
      end.converge(described_recipe)
    end

    include_context 'rhel_family'
  end

  context 'rhel' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '6.8') do |node|
        node.automatic['platform_family'] = 'rhel'
      end.converge(described_recipe)
    end

    include_context 'rhel_family'
  end

  context 'ubuntu' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04') do |node|
        node.automatic['platform_family'] = 'debian'
      end.converge(described_recipe)
    end

    include_examples 'icinga'

    %w(/etc/icinga2 /etc/icinga2/conf.d /etc/icinga2/objects.d /var/log/icinga2 /var/run/icinga2 /var/cache/icinga2 /etc/icinga2/pki /etc/icinga2/scripts /etc/icinga2/zones.d /etc/icinga2/features-enabled /etc/icinga2/features-available /opt/icinga2_custom_plugins /etc/icinga2/user_defined_objects /var/log/icinga2/compat /var/log/icinga2/compat/archives).each do |d|
      it "creates icinga2 directory #{d}" do
        expect(chef_run).to create_directory(d).with(
          owner: 'nagios',
          group: 'nagios'
        )
      end
    end

    it 'adds icinga2 repository' do
      expect(chef_run).to add_apt_repository('icinga2')
    end

    %w(g++ mailutils build-essential).each do |p|
      it "install package #{p}" do
        expect(chef_run).to install_package(p)
      end
    end

    it 'configure icinga2.conf' do
      expect(chef_run).to create_template('/etc/icinga2/icinga2.conf').with(
        source: 'icinga2.conf.erb',
        owner: 'nagios',
        group: 'nagios',
        mode: 0o644
      )
    end

    %w(constants.conf init.conf).each do |c|
      it "configure #{c}" do
        expect(chef_run).to create_template("/etc/icinga2/#{c}").with(
          source: "icinga2.#{c}.erb",
          owner: 'nagios',
          group: 'nagios',
          mode: 0o644
        )
      end
    end

    it 'configure icinga2 environment file' do
      expect(chef_run).to create_template('/etc/default/icinga2').with(
        source: 'icinga2.service.config.erb',
        owner: 'root',
        group: 'root',
        mode: 0o644
      )
    end
  end
end
