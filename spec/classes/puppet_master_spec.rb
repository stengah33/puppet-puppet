require 'spec_helper'

describe 'puppet::master' do

  if (Gem::Version.new(PUPPET_VERSION) > Gem::Version.new(2))
    master = 'master'
  else
    master = 'puppetmasterd'
  end

  OSES.each do |os|
    describe "When on #{os} with mysql" do
      let(:facts) { {
        :operatingsystem => os,
        :puppetversion   => PUPPET_VERSION,
        :puppetdbtype    => 'mysql',
        :puppetdbhost    => 'db.example.com',
        :puppetdbname    => 'puppetdb',
        :puppetdbuser    => 'puppet',
        :puppetdbpw      => 'P@S5w0Rd',
      } }

      it do should contain_package('puppetmaster').with(
        'ensure' => 'present',
        'name'   => VARS[os]['puppetmaster_pkg']
      ) end
      it { should contain_package('python-docutils').with_ensure('present') }

      if ['RedHat', 'CentOS', 'Fedora'].include? os
        it { should contain_package('ruby-rdoc').with_ensure('present') }
      end

      it do should contain_package('ruby-mysql').with(
        'ensure' => 'present',
        'name'   => 'libdbd-mysql-ruby'
      ) end

      it { should contain_puppet__config("#{master}/dbadapter").with_value('mysql') }
      it { should contain_puppet__config("#{master}/storeconfigs").with_value('true') }
      it { should contain_puppet__config("#{master}/dbmigrate").with_value('true') }
      it { should contain_puppet__config("#{master}/dbserver").with_value('db.example.com') }
      it { should contain_puppet__config("#{master}/dbname").with_value('puppetdb') }
      it { should contain_puppet__config("#{master}/dbuser").with_value('puppet') }
      it { should contain_puppet__config("#{master}/dbpassword").with_value('P@S5w0Rd') }
    end

    describe "When on #{os} with sqlite" do
      let(:facts) { {
        :operatingsystem => os,
        :puppetversion   => PUPPET_VERSION,
        :puppetdbtype    => 'sqlite',
        :puppetdbhost    => 'db.example.com',
        :puppetdbname    => 'puppetdb',
        :puppetdbuser    => 'puppet',
        :puppetdbpw      => 'P@S5w0Rd',
      } }

      it do should contain_package('puppetmaster').with(
        'ensure' => 'present',
        'name'   => VARS[os]['puppetmaster_pkg']
      ) end
      it { should contain_package('python-docutils').with_ensure('present') }

      if ['RedHat', 'CentOS', 'Fedora'].include? os
        it { should contain_package('ruby-rdoc').with_ensure('present') }
      end

      it { should contain_package('sqlite3').with_ensure('present') }
      it { should contain_package('libsqlite3-ruby').with_ensure('present') }

      it { should contain_puppet__config("#{master}/dbadapter").with_value('sqlite3') }
      it { should contain_puppet__config("#{master}/storeconfigs").with_value('true') }
      it { should contain_puppet__config("#{master}/dbmigrate").with_value('true') }
      it { should contain_puppet__config("#{master}/dbserver").with_value('db.example.com') }
      it { should contain_puppet__config("#{master}/dbname").with_value('puppetdb') }
      it { should contain_puppet__config("#{master}/dbuser").with_value('puppet') }
      it { should contain_puppet__config("#{master}/dbpassword").with_value('P@S5w0Rd') }
    end

    describe "When on #{os} with no puppetdbtype" do
      let(:facts) { {
        :operatingsystem => os,
        :puppetversion   => PUPPET_VERSION,
        :puppetdbtype    => nil,
      } }

      it { should contain_puppet__config("#{master}/dbadapter").with_value('default value') }
      it { should contain_puppet__config("#{master}/storeconfigs").with_value('false') }
      it { should contain_puppet__config("#{master}/dbmigrate").with_value('default value') }
      it { should contain_puppet__config("#{master}/dbserver").with_value('default value') }
      it { should contain_puppet__config("#{master}/dbname").with_value('default value') }
      it { should contain_puppet__config("#{master}/dbuser").with_value('default value') }
      it { should contain_puppet__config("#{master}/dbpassword").with_value('default value') }
    end
  end
end
