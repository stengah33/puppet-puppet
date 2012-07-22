module SpecParams
end

OSES = ['Debian', 'RedHat', 'Ubuntu', 'CentOS']

require 'puppet'
PUPPETVERSION = Puppet::PUPPETVERSION.to_s

VARS = {
  'Debian'             => {
    'puppetmaster_pkg' => 'puppetmaster',
    'lsb_release'      => 'lsb-release',
    'ruby_mysql'       => 'libdbd-mysql-ruby',
  },

  'RedHat' => {
    'puppetmaster_pkg' => 'puppet-server',
    'lsb_release'      => 'redhat-lsb',
    'ruby_mysql'       => 'ruby-mysql',
  },
}
VARS['Ubuntu'] = VARS['Debian']
VARS['CentOS'] = VARS['RedHat']

