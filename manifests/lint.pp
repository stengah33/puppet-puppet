class puppet::lint {
  package { 'puppet-lint':
    ensure => latest,
  }

  file { '/usr/local/bin/launch-puppet-lint':
    ensure => present,
    source => 'puppet:///modules/puppet/launch-puppet-lint',
  }
}
