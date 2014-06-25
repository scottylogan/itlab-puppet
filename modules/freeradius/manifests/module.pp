# manage Freeradius modules
define freeradius::module($ensure) {

  $radius_conf = "${freeradius::dbdir}/radiusd.conf"

  case $ensure {
    absent: {
      exec { "remove-freeradius-module-${name}":
        command => "sed -i -e '/\$INCLUDE modules\\/${name}/d' ${radius_conf}",
        onlyif  => "grep '^INCLUDE modules/${name}' ${radius_conf}",
        require => File[$radius_conf],
        notify  => Exec['reload freeradius']
      }
    }

    default: {
      exec { "add-freeradius-module-${name}":
          command => "sed -i -e '/^modules {/a\\    \$INCLUDE modules/${name}' ${radius_conf}",
          unless  => "grep 'INCLUDE modules/${name}' ${radius_conf}",
          require => File[$radius_conf],
          notify  => Exec['reload freeradius']
      }
    }
  }
}

