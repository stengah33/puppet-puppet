require 'spec_helper'

describe 'puppet::master::webrick' do
  describe 'When on Debian' do
    let(:facts) { {
      :operatingsystem => 'Debian'
    } }

    it do should contain_augeas('configure puppetmaster startup variables').with(
      'context' => '/files/etc/default/puppetmaster',
      'changes' => [
        'set PORT 8140',
        'set START yes',
        'set SERVERTYPE webrick',
        'set PUPPETMASTERS 1'
    ]) end

    it do should contain_service('puppetmaster').with(
      'ensure' => 'running',
      'enable' => 'true'
    ) end
  end

  describe 'When on RedHat' do
    let(:facts) { {
      :operatingsystem => 'RedHat'
    } }

    it do should contain_augeas('configure puppetmaster startup variables').with(
      'context' => '/files/etc/sysconfig/puppetmaster',
      'changes' => [
        'set PUPPETMASTER_EXTRA_OPTS \'"--servertype=webrick"\'',
        'rm  PUPPETMASTER_PORTS'
    ]) end

    it do should contain_service('puppetmaster').with(
      'ensure' => 'running',
      'enable' => 'true'
    ) end
  end
end
