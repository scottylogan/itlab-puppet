# manage Freeradius listeners
define freeradius::listener(
  $ensure,
  $type = 'auth',
  $ipaddr = 'NOCONTENT',
  $port = 'NOCONTENT',
  $interface = 'NOCONTENT',
  $clients = 'NOCONTENT',
) {

  $listener_type = $type
  $filename = "${freeradius::dbdir}/listeners/${name}"

  case $ensure {
    absent: {
      exec { "remove-freeradius-listener-${name}":
        command => "rm -f ${filename}",
        notify  => Exec['reload freeradius'],
      }
    }

    default: {

      file { $filename:
        ensure  => present,
        content => template('freeradius/listener.erb'),
        mode    => '0644',
        owner   => 'root',
        group   => $freeradius::group,
        notify  => Exec['reload freeradius'],
      }
    }
  }
}
