class nginx {

  package { 'nginx':
    ensure => present,
    require => Class['systemupdate'],
  }

  file { 'copy-default-config':
    ensure => file,
    path => '/etc/nginx/sites-enabled/default',
    source => 'puppet:///modules/nginx/sites-enabled/default',
    require => Package['nginx'],
    notify => Service['nginx'],
  }

  service { 'nginx':
    ensure => running,
    require => [
        Package['nginx'],
        File['copy-default-config']
    ]
  }
}
