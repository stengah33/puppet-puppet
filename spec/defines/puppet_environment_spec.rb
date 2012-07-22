require 'spec_helper'

describe 'puppet::environment' do
  describe 'When present' do
    let(:title) { 'foo' }
    let(:params) { { :path => '/home/foo' } }
    it { should contain_puppet__config('foo/modulepath').with_value('/home/foo/puppetmaster/modules:/home/foo/puppetmaster/site-modules') }
    it { should contain_puppet__config('foo/manifestdir').with_value('/home/foo/puppetmaster/manifests') }
    it { should contain_puppet__config('foo/manifest').with_value('/home/foo/puppetmaster/manifests/site.pp') }
  end

  describe 'When absent' do
    let(:title) { 'foo' }
    let(:params) { { :path => '/home/foo', :ensure => 'absent' } }
    it { should contain_augeas('remove environment foo').with_changes('rm /files/etc/puppet/puppet.conf/foo') }
  end

  describe 'When wrong value' do
    let(:title) { 'foo' }
    let(:params) { { :path => '/home/foo', :ensure => 'running' } }
    it do
      expect {
        should contain_puppet__config('foo/modulepath')
      }.to raise_error(Puppet::Error, /Wrong ensure parameter: running/)
    end
  end
end
