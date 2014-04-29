class openvpn {
  package {
    'openvpn': ensure => present
  }

  file {
    '/etc/openvpn':
      ensure  => directory,
      owner   => 'root',
      mode    => '0755',
  }

  file {
    '/var/log/openvpn':
      ensure  => directory,
      owner   => 'root',
      mode    => '0755',
  }

  service { 'openvpn':
    ensure     => running,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['openvpn'],
  }

  exec { 'openvpn reload':
    path         => '/bin:/usr/bin:/sbin:/usr/sbin',
    command      => 'service openvpn restart',
    refreshonly  => true,
    require      => Package['openvpn'],
  }
  
  file {
    '/etc/openvpn/update-resolv-conf':
      ensure  => absent,
      require => Package['openvpn'],
  }
  

}
