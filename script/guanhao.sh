echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install nano
apt-get install isc-dhcp-relay -y

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
INTERFACES="eth0 eth1 eth2 eth3"

# Additional options that are passed to the DHCP relay daemon?
OPTIONS=""
' > /etc/default/isc-dhcp-relay

#6
iptables -A PREROUTING -t nat -p tcp -d 10.16.4.128/29 --dport 80 -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination  10.16.9.2:80
iptables -A PREROUTING -t nat -p tcp -d 10.16.4.128/29 --dport 80 -j DNAT --to-destination 10.16.9.3:80
iptables -t nat -A POSTROUTING -p tcp -d 10.16.9.2 --dport 80 -j SNAT --to-source 10.16.4.128:80
iptables -t nat -A POSTROUTING -p tcp -d 10.16.9.3 --dport 80 -j SNAT --to-source 10.16.4.128:80

service isc-dhcp-relay restart