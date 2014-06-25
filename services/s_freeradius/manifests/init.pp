# Freeradius service

class s_freeradius inherits defaults {
  include freeradius
  include s_freeradius::clients

  freeradius::module { [
      'acct_unique',
      'attr_filter',
      'detail',
      'detail.log',
      'exec',
      'expiration',
      'files',
      'logintime',
      'preprocess',
      'radutmp',
      'realm',
      'eap',
    ]:
      ensure => present,
  }

  s3file { '/etc/freeradius/certs/server.key':
    ensure => present,
    owner  => 'root',
    group  => 'freerad',
    mode   => '0640',
    source => 'certs/radius/itlab-radius.key',
  }

  s3file { '/etc/freeradius/certs/server.pem':
    ensure => present,
    owner  => 'root',
    group  => 'freerad',
    mode   => '0640',
    source => 'certs/radius/itlab-radius.pem',
  }

  s3file { '/etc/freeradius/certs/ca.pem':
    ensure => present,
    owner  => 'root',
    group  => 'freerad',
    mode   => '0640',
    source => 'certs/radius/cloudpath-chain.pem',
  }

  file { '/etc/freeradius/certs/dh':
    ensure => present,
    owner  => 'root',
    group  => 'freerad',
    mode   => '0640',
    source => 'puppet:///modules/s_freeradius/certs/dh',
  }

  file { '/etc/freeradius/sites-available/default':
    ensure => present,
    owner  => 'root',
    group  => 'freerad',
    mode   => '0640',
    source => 'puppet:///modules/s_freeradius/sites-available/default',
  }

  file { '/etc/freeradius/users':
    ensure => present,
    owner  => 'root',
    group  => 'freerad',
    mode   => '0644',
    source => 'puppet:///modules/s_freeradius/users',
  }

  file { '/etc/freeradius/sites-enabled/inner-tunnel':
    ensure => absent,
  }

  freeradius::listener { 'default-auth':
    ensure => present,
  }

  freeradius::listener { 'default-acct':
    ensure => present,
    type   => 'acct',
  }
}
