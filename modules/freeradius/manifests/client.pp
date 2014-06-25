# manage Freeradius clients
define freeradius::client(
  $ensure,
  $ipaddr = 'NOCONTENT',
  $netmask = 32,
  $shortname = 'NOCONTENT',
  $nastype = 'other',
  $virtual_server = 'NOCONTENT',
  $secret = 'NOCONTENT',
) {

  $filename = "${freeradius::dbdir}/clients/${name}"

  case $ensure {
    absent: {
      exec { "remove-freeradius-client-${name}":
        command => "rm -f ${filename}",
        notify  => Exec['reload freeradius'],
      }
    }

    default: {
      if ($secret == 'NOCONTENT') {
        fail ('freeradius::client requires secret!')
      }

      if ($ipaddr == 'NOCONTENT') {
        fail ('freeradius::client requires ipaddr!')
      }

      file { $filename:
        ensure  => present,
        content => template('freeradius/client.erb'),
        mode    => '0644',
        owner   => 'root',
        group   => $freeradius::group,
        notify  => Exec['reload freeradius'],
      }
    }
  }
}
