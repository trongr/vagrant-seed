class nginx {

  package { 'nginx':
    ensure => present,
    require => Class['systemupdate'],
  }

  file { '/etc/nginx/sites-enabled/default':
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
        File['/etc/nginx/sites-enabled/default']
    ]
  }
}
