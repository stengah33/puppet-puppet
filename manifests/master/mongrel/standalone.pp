class puppet::master::mongrel::standalone inherits puppet::master::base {

  # TODO: make mongrel count configurable

  $mongrel = $::operatingsystem ? {
    /Debian|Ubuntu|kFreeBSD/ => 'mongrel',
    /RedHat|CentOS|Fedora/   => 'rubygem-mongrel',
  }

  package {'mongrel':
    ensure => present,
    name   => $mongrel,
  }

  service {'puppetmaster':
    ensure    => running,
    hasstatus => true,
    enable    => true,
    require   => Package['mongrel'],
  }

  $context = $::operatingsystem ? {
    /Debian|Ubuntu|kFreeBSD/ => '/files/etc/default/puppetmaster',
    /RedHat|CentOS|Fedora/   => '/files/etc/sysconfig/puppetmaster',
  }

  $changes = $::operatingsystem ? {
    /Debian|Ubuntu|kFreeBSD/ => [
      'set PORT 18140',
      'set START yes',
      'set SERVERTYPE mongrel',
      'set PUPPETMASTERS 4',
    ],
    /RedHat|CentOS|Fedora/ => [
      'set PUPPETMASTER_EXTRA_OPTS \'"--servertype=mongrel"\'',
      'set PUPPETMASTER_PORTS/1 18140',
      'set PUPPETMASTER_PORTS/2 18141',
      'set PUPPETMASTER_PORTS/3 18142',
      'set PUPPETMASTER_PORTS/4 18143',
    ],
  }

  augeas {'configure puppetmaster startup variables':
    context => $context,
    changes => $changes,
    notify  => Service['puppetmaster'],
  }

}
