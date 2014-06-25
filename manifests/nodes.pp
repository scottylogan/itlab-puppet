node idp                    { include s_idp }
node test                   { include s_test }

## VPN testing

node vpc-vpn                { include s_itlab_vpn::vpc }
node itlab-vpn              { include s_itlab_vpn::campus }

## 802.1X
node radius                 { include s_freeradius }

## Package building
node debuild                { include s_debuild }

## CloudPath AuthNZ
node cpauth                 { include s_cpauth }

node jira                   { include s_jira }
