# Default behavior for all Puppet managed IT Lab systems

class defaults {
  include
          base::cron,
#          base::dns,
#          base::iptables,
          base::kerberos,
#          base::newsyslog,
          base::ntp,
          base::os,
          base::pam,
          base::postfix,
          base::ssh,
          base::sudo,
#          base::sysctl::tcp_keepalive,
          base::syslog,
          base::tmpclean,
          user::itlab-users,
#          user::managed,
#          user::root,
          user::virtual

  # standard packages to add to every system
  package {
    [
      'less',
      'bash',
      'curl',
      'dnsutils',
      'cron',
      'man-db',
      'perl-doc',
      'file',
      'lsof',
      'strace',
      'xz-utils',
    ]:
      ensure => present,
  }

  # standard packages to remove from every system
  package {
    [
      'nano',
    ]:
      ensure => absent,
  }
  
#  base::iptables::fragment {
#    'udp-established': ensure => present;
#  }

  if ($::virtual == 'virtualbox') {
    # assume vagrant

    ssh_authorized_key {
      'vagrant insecure key':
        ensure => present,
        key    => 'AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ==',
        type   => 'ssh-rsa',
        user   => 'vagrant',
    }
  }

  if ($::ec2_ami_id != '') {
    # assume AWS, use itlab-aws key
    ssh_authorized_key {
      'itlab-aws':
        ensure => present,
        key    => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDGCoWDnYlWrEQP8e3S89wVvbnldZCw4NmmsHrjZtR2pGB3iGXA8HR8nHrrSOwDRbnX0WrD1TvJiDX3/NcmZMb0pcwIZWSzw09rGMBQ8b3eyN1PQONToWiWHvrDbChgeDWhZhOj2fyLT/N3K6Lxg0CXI7Az0rXEDWJgiwHKwW5vNJLLNIGBXDJUytqlQ5JtqTdL7q/mR5C5tpv/K6a+4zV35BHFgFoxp+houdlTzQwAwTCMZQj4+xyBh25EmRAygTShMae9UjmRMhrmlY5ZXF8iabNMLe9wbUZpoA2C4jqj+gokVzEP+f5Q+uzCdaZJYpESpmnWZMX/kmLb4QkkouPF',
        type   => 'ssh-rsa',
        user   => 'admin',
    }
  }

  # Set a default destination for root mail.
  base::postfix::recipient { 'root@itlab.stanford.edu':
    ensure => 'admin@itlab.stanford.edu',
  }
}
