class s_itlab_vpn::campus {
  include s_itlab_vpn

  openvpn::instance {
    'itlab':
        remote             => 'vpc-vpn.itlab.stanford.edu',
        shared_key_content => 'puppet:///modules/openvpn/itlab.key',
        tun_dev            => 'tun1',
        local_link_ip      => '169.254.1.1',
        remote_link_ip     => '169.254.1.2',
        routes             => [
            [ '10.96.7.0', '255.255.255.0' ],
        ],

  }
}


