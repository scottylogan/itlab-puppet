#
# Installs sudo

class base::sudo {
  package { 'sudo':
    ensure => installed
  }

  file { '/etc/sudoers.d':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/etc/sudoers.d/nopasswd-all':
    ensure  => present,
    content => "%root,%vagrant,%admin ALL=(ALL) NOPASSWD: ALL\n",
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
  }
}

