module SpecParams
end

OSES = ['Debian', 'RedHat', 'Ubuntu', 'CentOS']

if ENV.key?('PUPPET_VERSION')
  PUPPET_VERSION = ENV['PUPPET_VERSION']
else
  PUPPET_VERSION = '2.7.17'
end

VARS = {
  'Debian' => {
    'puppetmaster_pkg' => 'puppetmaster',
  },

  'RedHat' => {
    'puppetmaster_pkg' => 'puppet-server',
  },
}
VARS['Ubuntu'] = VARS['Debian']
VARS['CentOS'] = VARS['RedHat']

