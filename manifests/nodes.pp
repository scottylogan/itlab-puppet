node idp                    { include s_idp }
node test                   { include s_test }

## VPN testing

node vpc-vpn                { include s_itlab_vpn::vpc }
node itlab-vpn              { include s_itlab_vpn::campus }

