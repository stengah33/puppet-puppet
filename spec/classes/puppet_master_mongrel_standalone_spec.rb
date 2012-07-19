require 'spec_helper'

describe 'puppet::master::mongrel::standalone' do
  describe 'When on Debian' do
    let(:facts) { {
      :operatingsystem => 'Debian'
    } }

    it do should contain_package('mongrel').with(
      'ensure' => 'present',
      'name'   => 'mongrel'
    ) end

    it do should contain_service('puppetmaster').with(
      'ensure'    => 'running',
      'hasstatus' => 'true',
      'enable'    => 'true'
    ) end

    it do should contain_augeas('configure puppetmaster startup variables').with(
      'context' => '/files/etc/default/puppetmaster',
      'changes' => [
        'set PORT 18140',
        'set START yes',
        'set SERVERTYPE mongrel',
        'set PUPPETMASTERS 4'
    ]) end
  end

  describe 'When on RedHat' do
    let(:facts) { {
      :operatingsystem => 'RedHat'
    } }

    it do should contain_package('mongrel').with(
      'ensure' => 'present',
      'name'   => 'rubygem-mongrel'
    ) end

    it do should contain_service('puppetmaster').with(
      'ensure'    => 'running',
      'hasstatus' => 'true',
      'enable'    => 'true'
    ) end

    it do should contain_augeas('configure puppetmaster startup variables').with(
      'context' => '/files/etc/sysconfig/puppetmaster',
      'changes' => [
        'set PUPPETMASTER_EXTRA_OPTS \'"--servertype=mongrel"\'',
        'set PUPPETMASTER_PORTS/1 18140',
        'set PUPPETMASTER_PORTS/2 18141',
        'set PUPPETMASTER_PORTS/3 18142',
        'set PUPPETMASTER_PORTS/4 18143'
    ]) end
  end
end
