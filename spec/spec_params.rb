module SpecParams
end

OSES = ['Debian', 'RedHat', 'Ubuntu', 'CentOS']

require 'puppet'
PUPPETVERSION = Puppet::PUPPETVERSION.to_s

VARS = {
  'Debian'                 => {
    'puppetmaster_pkg'     => 'puppetmaster',
    'lsb_release'          => 'lsb-release',
    'ruby_mysql'           => 'libdbd-mysql-ruby',
    'mongrel'              => 'mongrel',
    'puppetmaster_default' => '/etc/default/puppetmaster',
    'mongrel_settings'     => [
      'set PORT 18140',
      'set START yes',
      'set SERVERTYPE mongrel',
      'set PUPPETMASTERS 4'
    ],
    'webrick_settings'     => [
      'set PORT 8140',
      'set START yes',
      'set SERVERTYPE webrick',
      'set PUPPETMASTERS 1'
    ],
  },

  'RedHat' => {
    'puppetmaster_pkg'     => 'puppet-server',
    'lsb_release'          => 'redhat-lsb',
    'ruby_mysql'           => 'ruby-mysql',
    'mongrel'              => 'rubygem-mongrel',
    'puppetmaster_default' => '/etc/sysconfig/puppetmaster',
    'mongrel_settings'     => [
      'set PUPPETMASTER_EXTRA_OPTS \'"--servertype=mongrel"\'',
      'set PUPPETMASTER_PORTS/1 18140',
      'set PUPPETMASTER_PORTS/2 18141',
      'set PUPPETMASTER_PORTS/3 18142',
      'set PUPPETMASTER_PORTS/4 18143',
    ],
    'webrick_settings'     => [
      'set PUPPETMASTER_EXTRA_OPTS \'"--servertype=webrick"\'',
      'rm  PUPPETMASTER_PORTS'
    ],
  },
}
VARS['Ubuntu'] = VARS['Debian']
VARS['CentOS'] = VARS['RedHat']

