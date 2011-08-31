class puppet::master::base {
  include mysql::server

  package { "puppetmaster":
    ensure => present,
    name   => $operatingsystem ? {
      /Debian|Ubuntu/        => "puppetmaster",
      /RedHat|CentOS|Fedora/ => "puppet-server",
    },
  }

  # used by puppetdoc -m pdf
  package { "python-docutils": ensure => present }

  package { "ruby-mysql":
    ensure => present,
    name   => $operatingsystem ? {
      /Debian|Ubuntu/        => "libdbd-mysql-ruby",
      /RedHat|CentOS|Fedora/ => "ruby-mysql",
    },
  }

  if $operatingsystem =~ /RedHat|CentOS|Fedora/ {
    package { "ruby-rdoc": ensure => present }
  }

  # Database
  mysql::database { "puppet":
    ensure => present,
  }

  mysql::rights { "Set rights for puppet database":
    ensure   => present,
    database => "puppet",
    user     => "puppet",
    password => "puppet"
  }
}
