require 'spec_helper'

describe 'puppet::master::passenger' do
  describe 'When using defaults' do
    it { should include_class('apache::params') }
    it { should include_class('ruby::gems') }
    it { should include_class('ruby::passenger::apache') }

    it { should contain_apache__module('passenger') }

    it do should contain_apache__vhost-ssl('puppetmasterd').with(
      'mode' => '2755',
      'user' => 'root'
    ) end

    it { should contain_apache__listen('8140') }

    it do should contain_file('/etc/puppet/rack').with(
      'ensure' => 'directory',
      'mode'   => '0755',
      'owner'  => 'root',
      'group'  => 'root'
    ) end

    it do should contain_file('/etc/puppet/rack/public').with(
      'ensure' => 'directory',
      'mode'   => '0755',
      'owner'  => 'root',
      'group'  => 'root'
    ) end

    it do should contain_file('/etc/puppet/rack/tmp').with(
      'ensure' => 'directory',
      'mode'   => '0755',
      'owner'  => 'root',
      'group'  => 'root'
    ) end

    it do should contain_file('/etc/puppet/rack/config.ru').with(
      'ensure' => 'present',
      'mode'   => '0644',
      'owner'  => 'puppet',
      'group'  => 'root'
    ) end

    it do should contain_package('activerecord').with(
      'ensure'   => '2.3.2',
      'provider' => 'gem'
    ) end

    it do should contain_package('rack').with(
      'ensure'   => '1.0.0',
      'provider' => 'gem'
    ) end
  end
end
