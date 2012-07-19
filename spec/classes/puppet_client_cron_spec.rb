require 'spec_helper'

describe 'puppet::client::cron' do
  describe 'When on Debian' do
    let(:facts) { {
      :operatingsystem    => 'Debian',
      :ipaddress          => '10.0.0.1',
      :puppet_server      => 'pm.example.com',
    } }

    it do should contain_service('puppet').with(
      'ensure'    => 'stopped',
      'enable'    => 'false',
      'hasstatus' => 'false',
      'pattern'   => 'ruby /usr/sbin/puppetd -w 0'
    ) end

    it do should contain_file('/usr/local/bin/launch-puppet').with(
      'ensure'  => 'present',
      'mode'    => '0755'
    ) end

    it do should contain_cron('puppetd').with(
      'ensure'      => 'present',
      'command'     => '/usr/local/bin/launch-puppet',
      'user'        => 'root',
      'environment' => 'MAILTO=root',
      'minute'      => 'unknown'
    ) end
  end
end
