require 'spec_helper'

describe 'puppet::client::base' do
  describe 'When on Debian and puppet 0.25.5' do
    let(:facts) { { :operatingsystem     => 'Debian',
                    :puppetversion       => '0.25.5',
                    :puppet_server       => 'pm.example.com',
                    :puppet_reportserver => 'reports.example.com',
                    :puppet_environment  => 'foobar'
                } } 

    it { should contain_package('facter').with_ensure('present') }
    it { should contain_package('puppet').with_ensure('present') }
    it { should contain_package('lsb-release').with_ensure('present') }

    it { should contain_user('puppet').with_ensure('present') }

    it { should contain_puppet__config('main/ssldir').with_value('/var/lib/puppet/ssl') }
    it { should contain_puppet__config('puppetd/server').with_value('pm.example.com') }
    it { should contain_puppet__config('puppetd/reportserver').with_value('reports.example.com') }
    it { should contain_puppet__config('puppetd/report').with_value('true') }
    it { should contain_puppet__config('puppetd/configtimeout').with_value('3600') }
    it { should contain_puppet__config('puppetd/pluginsync').with_value('true') }
    it { should contain_puppet__config('puppetd/plugindest').with_value('/var/lib/puppet/lib') }
    it { should contain_puppet__config('puppetd/libdir').with_value('/var/lib/puppet/lib') }
    it { should contain_puppet__config('puppetd/pidfile').with_value('/var/run/puppet/puppetd.pid') }
    it { should contain_puppet__config('puppetd/environment').with_value('foobar') }
    it { should contain_puppet__config('puppetd/diff_args').with_value('-u') }
  end
end
