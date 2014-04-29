# Default behavior for all Puppet managed IT Lab systems

class defaults {
  include base::sudo,
          user::itlab-users,
          user::virtual

  # Packages that all nodes get regardless of operating system.
  package {
    [
      'less',
      'bash',
      'curl',
      'dnsutils',
    ]:
      ensure => present,
  }
}
