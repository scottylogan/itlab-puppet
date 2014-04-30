class s_itlab_vpn inherits defaults {
  include openvpn
  
  $itlab_key = 'puppet:///modules/s_itlab_vpn/etc/openvpn/itlab.key'

}