Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

class systemupdate {
  exec { 'apt-get update':
    command => 'apt-get update',
  }

  package { ["build-essential"]:
    ensure => installed,
    require => Exec['apt-get update'],
  }

}

class configs {
    file { '/home/vagrant':
        ensure => directory,
        path => '/home/vagrant',
        source => "puppet:///modules/configs/homevagrant",
        recurse => true,
        owner => "vagrant",
        group => "vagrant",
        mode => 0644
    }

    # file to log your terminal commands, used in .bashrc
    file { "/home/vagrant/nv/logs":
        ensure => directory,
    }
}

include systemupdate, configs
include nginx, git, nodejs

package { 'express':
  ensure   => present,
  provider => 'npm',
}

package { 'mime':
  ensure   => 'stable',
  provider => 'npm',
}
