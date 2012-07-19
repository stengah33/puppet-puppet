require 'spec_helper'

describe 'puppet::lint' do
  let(:facts) { {:operatingsystem => 'Debian'} }

  it do should contain_file('/usr/local/bin/launch-puppet-lint').with(
    'ensure' => 'present',
    'mode'   => '0755',
    'source' => 'puppet:///modules/puppet/launch-puppet-lint'
  ) end
end
