class puppet::client::daemon {

  include puppet::client::base

  service { "puppet":
    ensure    => running,
    enable    => true,
    hasstatus => true,
    pattern   => $operatingsystem ? {
      Debian => "ruby /usr/sbin/puppetd -w 0",
      Ubuntu => "ruby /usr/sbin/puppetd -w 0",
      RedHat => "/usr/bin/ruby /usr/sbin/puppetd$",
      CentOS => "/usr/bin/ruby /usr/sbin/puppetd$",
    }
  }

  file { "/usr/local/bin/launch-puppet":
    ensure => absent,
  }

  cron { "puppetd":
    ensure => absent,
    user   => "root",
  }
}
