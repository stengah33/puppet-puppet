class puppet::master::mongrel::standalone inherits puppet::master::base {

  package { "mongrel":
    ensure => present,
  }

  service { "puppetmaster":
    ensure    => running,
    hasstatus => true,
    enable    => true,
    require   => Package["mongrel"],
  }

  #TODO: this won't work for redhat/centos
  augeas { "configure puppetmaster startup variables":
    context => "/files/etc/default/puppetmaster",
    changes => [
      "set PORT 18140",
      "set START yes",
      "set SERVERTYPE mongrel",
      "set PUPPETMASTERS 4",
    ],
    notify  => Service["puppetmaster"],
  }

}
