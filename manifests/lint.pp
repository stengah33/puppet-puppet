class puppet::lint {
  $package = $::operatingsystem ? {
    /Debian|Ubuntu/ => 'puppet-lint',
    /RedHat|CentOS/ => 'rubygem-puppet-lint',
  }

  package { $package:
    ensure => latest,
  }

  file { '/usr/local/bin/launch-puppet-lint':
    ensure => present,
    mode   => '0755',
    source => 'puppet:///modules/puppet/launch-puppet-lint',
  }
}
