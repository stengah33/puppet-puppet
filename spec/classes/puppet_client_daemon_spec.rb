require 'spec_helper'

describe 'puppet::client::daemon' do
  let(:facts) { { :operatingsystem     => 'Debian',
                  :puppetversion       => '0.25.5',
                  :puppet_server       => 'pm.example.com',
                  :puppet_reportserver => 'reports.example.com',
                  :puppet_environment  => 'someuser'
              } } 

  it { should include_class('puppet::client::base') }

  it do should contain_service('puppet').with(
    'ensure'    => 'running',
    'enable'    => 'true',
    'hasstatus' => 'true'
  ) end

  it { should contain_file('/usr/local/bin/launch-puppet').with_ensure('absent') }

  it do should contain_cron('puppetd').with(
    'ensure' => 'absent',
    'user'   => 'root'
  ) end
end
