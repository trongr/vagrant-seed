exec { 'apt-get update':
  path => '/usr/bin',
}

include nginx
