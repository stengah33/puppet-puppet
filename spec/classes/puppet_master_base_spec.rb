require 'spec_helper'

describe 'puppet::master::base' do
  describe 'When on Debian with puppet 0.25.5 and mysql' do
    let(:facts) { {
      :operatingsystem => 'Debian',
      :puppetversion   => '0.25.5',
      :puppetdbtype    => 'mysql',
      :puppetdbhost    => 'db.example.com',
      :puppetdbname    => 'puppetdb',
      :puppetdbuser    => 'puppet',
      :puppetdbpw      => 'P@S5w0Rd',
    } }

    it do should contain_package('puppetmaster').with(
      'ensure' => 'present',
      'name'   => 'puppetmaster'
    ) end
    it { should contain_package('python-docutils').with_ensure('present') }

    it do should contain_package('ruby-mysql').with(
      'ensure' => 'present',
      'name'   => 'libdbd-mysql-ruby'
    ) end

    it { should contain_puppet__config('puppetmasterd/dbadapter').with_value('mysql') }
    it { should contain_puppet__config('puppetmasterd/storeconfigs').with_value('true') }
    it { should contain_puppet__config('puppetmasterd/dbmigrate').with_value('true') }
    it { should contain_puppet__config('puppetmasterd/dbserver').with_value('db.example.com') }
    it { should contain_puppet__config('puppetmasterd/dbname').with_value('puppetdb') }
    it { should contain_puppet__config('puppetmasterd/dbuser').with_value('puppet') }
    it { should contain_puppet__config('puppetmasterd/dbpassword').with_value('P@S5w0Rd') }
  end

  describe 'When on RedHat with puppet 2.6.17 and sqlite' do
    let(:facts) { {
      :operatingsystem => 'RedHat',
      :puppetversion   => '2.6.17',
      :puppetdbtype    => 'sqlite',
      :puppetdbhost    => 'db.example.com',
      :puppetdbname    => 'puppetdb',
      :puppetdbuser    => 'puppet',
      :puppetdbpw      => 'P@S5w0Rd',
    } }

    it do should contain_package('puppetmaster').with(
      'ensure' => 'present',
      'name'   => 'puppet-server'
    ) end
    it { should contain_package('python-docutils').with_ensure('present') }
    it { should contain_package('ruby-rdoc').with_ensure('present') }

    it { should contain_package('sqlite3').with_ensure('present') }
    it { should contain_package('libsqlite3-ruby').with_ensure('present') }

    it { should contain_puppet__config('puppetmasterd/dbadapter').with_value('sqlite3') }
    it { should contain_puppet__config('puppetmasterd/storeconfigs').with_value('true') }
    it { should contain_puppet__config('puppetmasterd/dbmigrate').with_value('true') }
    it { should contain_puppet__config('puppetmasterd/dbserver').with_value('db.example.com') }
    it { should contain_puppet__config('puppetmasterd/dbname').with_value('puppetdb') }
    it { should contain_puppet__config('puppetmasterd/dbuser').with_value('puppet') }
    it { should contain_puppet__config('puppetmasterd/dbpassword').with_value('P@S5w0Rd') }
  end

  describe 'When no puppetdbtype on RedHat with puppet 2.6.17' do
    let(:facts) { {
      :operatingsystem => 'RedHat',
      :puppetversion   => '2.6.17',
      :puppetdbtype    => nil,
    } }

    it { should contain_puppet__config('puppetmasterd/dbadapter').with_value(nil) }
    it { should contain_puppet__config('puppetmasterd/storeconfigs').with_value('false') }
    it { should contain_puppet__config('puppetmasterd/dbmigrate').with_value(nil) }
    it { should contain_puppet__config('puppetmasterd/dbserver').with_value(nil) }
    it { should contain_puppet__config('puppetmasterd/dbname').with_value(nil) }
    it { should contain_puppet__config('puppetmasterd/dbuser').with_value(nil) }
    it { should contain_puppet__config('puppetmasterd/dbpassword').with_value(nil) }
  end
end
