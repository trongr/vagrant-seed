class systemupdate {
  exec { 'apt-get update':
    command => 'apt-get update',
  }

  $buildpack = [ "build-essential" ]

  package { $buildpack:
    ensure => installed,
    require => Exec['apt-get update'],
  }
}
