# Create an OpenVPN configuration / instance
#
define openvpn::instance(
  $ensure = 'present',
  $conf_template = 'openvpn/openvpn.conf.erb',
  $remote = 'NOSRC',
  $shared_key_content = 'NOSRC',
  $tun_dev = 'tun0',
  $local_link_ip = '169.254.1.1',
  $remote_link_ip = '169.254.1.2',
  $routes = 'NOSRC' )
{
  if ($remote == 'NOSRC') {
    fail ('openvpn::instance requires remote!')
  }
  if ($routes == 'NOSRC') {
    fail ('openvpn::instance requires routes!')
  }
  if ($shared_key_content == 'NOSRC') {
    fail ('openvpn::instance requires shared_key_content!')
  }

  $shared_key_path = "/etc/openvpn/${name}.key"

  file { "/etc/openvpn/${name}.conf":
    ensure  => present,
    content => template($conf_template),
    mode    => '0644',
    owner   => 'root',
    group   => 'root'
  }

  file { $shared_key_path:
    ensure  => present,
    source  => $shared_key_content,
    mode    => '0600',
    owner   => 'root',
    group   => 'root',
    notify  => Service['openvpn'],
  }
}
