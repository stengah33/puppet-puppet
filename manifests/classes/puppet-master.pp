class puppet::master {
  include mysql::server

  package {
    "puppetmaster": ensure => present;
#    "rails": ensure => present;
    "libdbd-sqlite3-ruby": ensure => present;
    "rdoc": ensure => present;
    "pwgen": ensure => present;
    "python-mysqldb": ensure => present;
    "libdbd-mysql-ruby": ensure => present;
  }

  # Custom functions
  file { "/usr/local/lib/site_ruby":
    ensure => directory,
  }

  file { "/usr/local/lib/site_ruby/puppet":
    ensure  => directory,
    require => File["/usr/local/lib/site_ruby"],
  }

  file { "/usr/local/lib/site_ruby/puppet/parser":
    ensure  => directory,
    require => File["/usr/local/lib/site_ruby/puppet"],
  }

  file { "/usr/local/lib/site_ruby/puppet/parser/functions":
    ensure  => "/etc/puppetmaster/functions",
    require => File["/usr/local/lib/site_ruby/puppet/parser"],
  }

  # Configuration
  #file {"/etc/default/puppetmaster":
  #  ensure  => present,
  #  source  => "puppet:///puppet/puppetmaster.default",
  #  notify  => Service["puppetmaster"],
  #}

  service {"puppetmaster":
    ensure  => running,
    enable  => true,
    require => Package["puppetmaster"],
  }

  # Database
  mysql::database{"puppet":
    ensure => present,
  }

  mysql::rights{"Set rights for puppet database":
    ensure   => present,
    database => "puppet",
    user     => "puppet",
    password => "puppet"
  }
}
