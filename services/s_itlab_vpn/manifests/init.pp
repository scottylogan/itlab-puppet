class s_itlab_vpn {
  include openvpn

  package {
    [ 'less', 'curl', 'tcpdump' ]:
      ensure => 'present'
  }

}