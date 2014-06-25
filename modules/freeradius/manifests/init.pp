# Install Freeradius packages

class freeradius (
  $user   = 'freerad',
  $group  = 'freerad',
  $logdir = '/var/log/freeradius',
  $dbdir  = '/etc/freeradius',
  $rundir = '/var/run/freeradius',
  $tmpdir = '/var/tmp/freeradius',
) {

  package {
    'freeradius':       ensure => present;
    'freeradius-utils': ensure => present;
  }

  # Ensure that Freeradius is running.

  service { 'freeradius':
    ensure     => running,
    hasrestart => true,
    hasstatus  => false,
    status     => 'pidof /usr/sbin/freeradius',
    require    => Package['freeradius'],
  }

  group { $group:
    ensure  => present,
    system  => true,
    require => Package['freeradius'],
  }

  user { $user:
    ensure  => present,
    system  => true,
    home    => $dbdir,
    gid     => $group,
    shell   => '/bin/false',
    require => Package['freeradius'],
  }

  exec { 'reload freeradius':
    path         => '/bin:/usr/bin:/sbin:/usr/sbin',
    command      => 'service freeradius restart',
    refreshonly  => true,
    require      => Package['freeradius'],
  }

  file {
    [
      $dbdir,
      "${dbdir}/certs",
      "${dbdir}/clients",
      "${dbdir}/listeners",
      "${dbdir}/modules",
      "${dbdir}/sites-available",
      "${dbdir}/sites-enabled",
    ]:
      ensure  => directory,
      owner   => 'root',
      group   => $group,
      mode    => '2751',
      require => Package['freeradius'],
  }

  file {
    [
      $tmpdir,
      $logdir,
      "${logdir}/radacct",
      $rundir,
    ]:
      ensure  => directory,
      owner   => $user,
      group   => $group,
      mode    => '2751',
      require => Package['freeradius'],
  }

  file { '/etc/freeradius/client-verify':
    ensure  => present,
    source => 'puppet:///modules/freeradius/client-verify',
    owner   => 'root',
    group   => $group,
    mode    => '755',
  }

  file { '/etc/freeradius/client-verify-real':
    ensure  => present,
    source => 'puppet:///modules/freeradius/client-verify-real',
    owner   => 'root',
    group   => $group,
    mode    => '755',
  }

  file { '/etc/freeradius/sites-enabled/default':
    ensure  => link,
    target  => '../sites-available/default',
    require => Package['freeradius'],
    notify  => Exec['reload freeradius'],
  }

  file { '/etc/freeradius/radiusd.conf':
    ensure  => present,
    content => template('freeradius/radiusd.conf.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => $group,
    require => Package['freeradius'],
    notify  => Exec['reload freeradius'],
  }
  
  # remove the standard clients.conf; we're
  # using a file for each client under clients/
  file { '/etc/freeradius/clients.conf':
    ensure => absent,
  }

  # remove the standard eap configuration
  file { '/etc/freeradius/eap.conf':
    ensure => absent,
  }

  # and replace with ours, but in the modules directory
  # (like all the other modules)
  file { '/etc/freeradius/modules/eap':
    ensure => present,
    owner  => 'root',
    group  => 'freerad',
    mode   => '0644',
    source => 'puppet:///modules/freeradius/modules/eap',
  }

  

}