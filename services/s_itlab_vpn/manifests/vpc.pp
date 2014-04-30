class s_itlab_vpn::vpc inherits s_itlab_vpn {
  
  openvpn::instance {
    'itlab':
        remote             => 'itlab-vpn2.stanford.edu',
        shared_key_content => $itlab_key,
        tun_dev            => 'tun0',
        local_link_ip      => '169.254.1.2',
        remote_link_ip     => '169.254.1.1',
        routes             => [
            [ '10.35.0.0',    '255.255.255.0'   ],
            [ '171.64.11.53', '255.255.255.255' ],
        ],

  }
}


