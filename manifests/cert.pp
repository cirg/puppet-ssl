class ssl::cert (
  $source
) {
  file { "/usr/local/share/ca-certificates/${name}.crt":
    source => $source,
  }

  file { "/etc/ssl/certs/${name}":
    ensure => link,
    target => "/usr/local/share/ca-certificates/${name}",
    notify => Exec['/usr/bin/c_rehash /etc/ssl/certs'],
  }

  exec { '/usr/bin/c_rehash /etc/ssl/certs':
    refreshonly => true,
  }
}
