apt-get update
apt-get install nano
apt-get install isc-dhcp-relay -y

################ Routing sayap kiri ##############
route add -net 10.16.4.0 netmask 255.255.255.128 gw 10.16.5.2
route add -net 10.16.0.0 netmask 255.255.252.0 gw 10.16.5.2
route add -net 10.16.4.128 netmask 255.255.255.248 gw 10.16.5.2

################ Routing sayap kanan #############
route add -net 10.16.12.0 netmask 255.255.254.0 gw 10.16.10.2
route add -net 10.16.8.0 netmask 255.255.255.0 gw 10.16.10.2
route add -net 10.16.9.0 netmask 255.255.255.248 gw 10.16.10.2

echo '
# Defaults for isc-dhcp-relay initscript
# sourced by /etc/init.d/isc-dhcp-relay
# installed at /etc/default/isc-dhcp-relay by the maintainer scripts

#
# This is a POSIX shell fragment
#

# What servers should the DHCP relay forward requests to?
SERVERS="10.16.4.131"

# On what interfaces should the DHCP relay (dhrelay) serve DHCP requests?
INTERFACES="eth0 eth1 eth2"

# Additional options that are passed to the DHCP relay daemon?
OPTIONS=""
' > /etc/default/isc-dhcp-relay