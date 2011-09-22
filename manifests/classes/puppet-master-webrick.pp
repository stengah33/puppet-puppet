class puppet::master::webrick inherits puppet::master::base {

  #TODO: this won't work for redhat/centos
  augeas { "configure puppetmaster startup variables":
    context => "/files/etc/default/puppetmaster",
    changes => [
      "set PORT 8140",
      "set START yes",
      "set SERVERTYPE webrick",
      "set PUPPETMASTERS 1",
    ],
    notify  => Service["puppetmaster"],
  }

  service { "puppetmaster":
    ensure  => running,
    enable  => true,
    require => Package["puppetmaster"],
  }

}
