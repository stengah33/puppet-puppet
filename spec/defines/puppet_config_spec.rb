require 'spec_helper'

describe 'puppet::config' do
  describe 'When using default value' do
    let(:title) { 'bar' }
    it { should contain_augeas("set puppet config parameter 'bar' to 'default value'").with_context('/files/etc/puppet/puppet.conf') }
  end
end
