class nginx {

  package { 'nginx':
    ensure => present,
    require => Exec['apt-get update'],
  }

  file { 'copy-default-nginx-config':
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
        File['copy-default-nginx-config']
    ]
  }
}
