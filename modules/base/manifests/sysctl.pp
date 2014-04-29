#
# Example of how to set a value in sysctl.conf
#   base::sysctl { "kernel.sysreq": ensure => "0"  }
#
# Example of how to ensure there is no value in sysctl.conf
#   base::sysctl { "kernel.sysreq": ensure => absent  }
#

define base::sysctl($ensure) {
  package {
    'procps': ensure => present,
  }

  $dirname = '/etc/sysctl.d'

  # Reload sysctl values after configuration is changed.
  exec { 'reload sysctld-system':
    command     => '/sbin/sysctl --system',
    refreshonly => true
  }

  case $ensure {
    absent: {
      file { "$dirname/$name":
        ensure => absent,
      }
    }

    default: {
      $line = "$name = $ensure"
      file { "$dirname/$name.conf":
        ensure   => present,
        owner    => 'root',
        group    => 'root',
        mode     => '0644',
        content  => $line,
        notify   => Exec['reload sysctld-system'],
      }
    }
  }
}
