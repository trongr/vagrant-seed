Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/", "/usr/local/bin/", "/usr/local/sbin/" ] }

class aptgetupdate {
    exec { "apt-get update":
        command => "apt-get update",
    }
}

class devtools {
    package { "git":
        ensure => latest,
        require => Class["aptgetupdate"]
    }

    package { ["curl", "wget", "htop", "g++"]:
        ensure => present,
        require => Class["aptgetupdate"]
    }

}

class nginx {
  package { 'nginx':
    ensure => present,
    require => Class['aptgetupdate'],
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

class nodejs {
  exec { "git_clone_n":
    command => "rm -rf n && git clone https://github.com/visionmedia/n.git n",
    cwd => "/home/vagrant",
    require => [Class["aptgetupdate"], Class["devtools"]]
  }

  exec { "install_n":
    command => "make install",
    cwd => "/home/vagrant/n",
    require => Exec["git_clone_n"]
  }

  exec { "install_node":
    command => "n stable",
    require => [Exec["git_clone_n"], Exec["install_n"]]
  }
}

class npmpackages {
    # TODO if these work add them to npm install -g:
    # karma bower...
    exec { "npminstallglobal":
        command => "npm install -g karma bower grunt-cli express-generator yo",
        require => Class["nodejs"]
    }
}

class mongodb {
  class {'::mongodb::globals':
    manage_package_repo => true,
    bind_ip             => ["127.0.0.1"],
  }->
  class {'::mongodb::server':
    port    => 27017,
    verbose => true,
    ensure  => "present"
  }->
  class {'::mongodb::client': }
}

include aptgetupdate, devtools
include nginx, nodejs, npmpackages, mongodb
