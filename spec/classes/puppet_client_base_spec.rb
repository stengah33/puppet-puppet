require 'spec_helper'

describe 'puppet::client::base' do
  describe 'When on Debian and puppet 0.25.5' do
    let(:facts) { { :operatingsystem => 'Debian', :puppetversion => '0.25.5' } }

    it { should contain_package('facter').with_ensure('present') }
    it { should contain_package('puppet').with_ensure('present') }
    it { should contain_package('lsb-release').with_ensure('present') }

    it { should contain_user('puppet').with_ensure('present') }

    it { should contain_puppet__config('main/ssldir').with_value('/var/lib/puppet/ssl') }
  end
end
