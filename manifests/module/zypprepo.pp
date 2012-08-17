class puppet::module::zypprepo {

  file{ '/etc/puppet/modules/':
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 755,
  }

  exec {'puppet_module_darin_zypprepo':
    command => 'puppet module install darin/zypprepo',
    path    => "/bin/:/usr/bin/:/usr/local/bin/:",
    cwd     => '/etc/puppet/modules/',
    onlyif  => "puppet module list | grep darin-zypprepo && exit 1 || exit 0",
  }

}
