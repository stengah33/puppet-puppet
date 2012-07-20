require 'spec_helper'

describe 'puppet::master::passenger' do
  let(:pre_condition) { "
class apache::params {}
define apache::vhost::ssl($ensure='present', $config_content, $mode, $user) {}
define apache::module($ensure='present') {}
define apache::listen($ensure='present') {}

class ruby::gems {}
class ruby::passenger::apache {}
    "
  }


  describe 'When using defaults on Debian' do
    let(:facts) { {
      :operatingsystem => 'Debian'
    } }

    it { should include_class('apache::params') }
    it { should include_class('ruby::gems') }
    it { should include_class('ruby::passenger::apache') }

    it { should contain_apache__module('passenger') }

    it do should contain_apache__vhost__ssl('puppetmasterd').with(
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

  describe 'When setting variables on RedHat' do
    let(:facts) { {
      :operatingsystem      => 'RedHat',
      :puppetmaster_ssldir  => '/etc/ssl/puppet',
      :puppet_server        => 'pm.example.com',
      :wwwroot              => '/var/www',
      :rack_version         => '1.2.3',
      :activerecord_version => '3.2.1',
      :puppetmaster_timeout => '314'
    } }

    it { should include_class('apache::params') }
    it { should include_class('ruby::gems') }
    it { should include_class('ruby::passenger::apache') }

    it { should contain_apache__module('passenger') }

    it do should contain_apache__vhost__ssl('puppetmasterd').with(
      'mode' => '2755',
      'user' => 'root'
    ) end

    it { should contain_apache__listen('8140') }

    it do should contain_file('/var/www/puppetmasterd/htdocs/rack').with(
      'ensure' => 'directory',
      'mode'   => '0755',
      'owner'  => 'root',
      'group'  => 'root'
    ) end

    it do should contain_file('/var/www/puppetmasterd/htdocs/rack/public').with(
      'ensure' => 'directory',
      'mode'   => '0755',
      'owner'  => 'root',
      'group'  => 'root'
    ) end

    it do should contain_file('/var/www/puppetmasterd/htdocs/rack/tmp').with(
      'ensure' => 'directory',
      'mode'   => '0755',
      'owner'  => 'root',
      'group'  => 'root'
    ) end

    it do should contain_file('/var/www/puppetmasterd/htdocs/rack/config.ru').with(
      'ensure' => 'present',
      'mode'   => '0644',
      'owner'  => 'puppet',
      'group'  => 'root'
    ) end

    it do should contain_package('activerecord').with(
      'ensure'   => '3.2.1',
      'provider' => 'gem'
    ) end

    it do should contain_package('rack').with(
      'ensure'   => '1.2.3',
      'provider' => 'gem'
    ) end
  end
end
