class puppet::client::cron {

  include puppet::client::base

  $puppet_pattern = $::operatingsystem ? {
      /Debian|Ubuntu/ => 'ruby /usr/sbin/puppetd -w 0',
      /RedHat|CentOS/ => '/usr/bin/ruby /usr/sbin/puppetd$',
  }

  service {'puppet':
    ensure    => stopped,
    enable    => false,
    hasstatus => false,
    pattern   => $puppet_pattern,
  }

  file {'/usr/local/bin/launch-puppet':
    ensure  => present,
    mode    => '0755',
    content => template('puppet/launch-puppet.erb'),
  }

  cron {'puppetd':
    ensure      => present,
    command     => '/usr/local/bin/launch-puppet',
    user        => 'root',
    environment => 'MAILTO=root',
    minute      => $puppet_run_minutes ? {
      ''        => ip_to_cron(2),
      '*'       => undef,
      default   => $puppet_run_minutes,
    },
    hour      => $puppet_run_hours ? {
      ''      => undef,
      '*'     => undef,
      default => $puppet_run_hours,
    },
    require   => File['/usr/local/bin/launch-puppet'],
  }
}
