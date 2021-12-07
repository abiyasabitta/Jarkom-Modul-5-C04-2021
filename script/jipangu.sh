echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install nano
apt-get install isc-dhcp-server -y

echo '
# Defaults for isc-dhcp-server initscript
# sourced by /etc/init.d/isc-dhcp-server
# installed at /etc/default/isc-dhcp-server by the maintainer scripts

#
# This is a POSIX shell fragment
#

# Path to dhcpds config file (default: /etc/dhcp/dhcpd.conf).
#DHCPD_CONF=/etc/dhcp/dhcpd.conf

# Path to dhcpds PID file (default: /var/run/dhcpd.pid).
#DHCPD_PID=/var/run/dhcpd.pid

# Additional options to start dhcpd with.
#       Dont use options -cf or -pf here; use DHCPD_CONF/ DHCPD_PID instead
#OPTIONS=

# On what interfaces should the DHCP server (dhcpd) serve DHCP requests?
#       Separate multiple interfaces with spaces, e.g. eth0 eth1.
INTERFACES="eth0"
' > /etc/default/isc-dhcp-server

echo '
# Defaults for isc-dhcp-server initscript
# sourced by /etc/init.d/isc-dhcp-server
# installed at /etc/default/isc-dhcp-server by the maintainer scripts

#
# This is a POSIX shell fragment
#

# Path to dhcpds config file (default: /etc/dhcp/dhcpd.conf).
#DHCPD_CONF=/etc/dhcp/dhcpd.conf

# Path to dhcpds PID file (default: /var/run/dhcpd.pid).
#DHCPD_PID=/var/run/dhcpd.pid

# Additional options to start dhcpd with.
#       Dont use options -cf or -pf here; use DHCPD_CONF/ DHCPD_PID instead
#OPTIONS=

# On what interfaces should the DHCP server (dhcpd) serve DHCP requests?
#       Separate multiple interfaces with spaces, e.g. eth0 eth1.
INTERFACES="eth0"
' > /etc/default/isc-dhcp-server

echo '
#
# Sample configuration file for ISC dhcpd for Debian
#
# Attention: If /etc/ltsp/dhcpd.conf exists, that will be used as
# configuration file instead of this file.
#
#

# The ddns-updates-style parameter controls whether or not the server will
# attempt to do a DNS update when a lease is confirmed. We default to the
# behavior of the version 2 packages (none, since DHCP v2 didnt
# have support for DDNS.)
ddns-update-style none;

# option definitions common to all supported networks...
option domain-name "example.org";
option domain-name-servers ns1.example.org, ns2.example.org;

default-lease-time 600;
max-lease-time 7200;

# If this DHCP server is the official DHCP server for the local
# network, the authoritative directive should be uncommented.
#authoritative;

# Use this to send dhcp log messages to a different log file (you also
# have to hack syslog.conf to complete the redirection).
log-facility local7;

# No service will be given on this subnet, but declaring it helps the 
# DHCP server to understand the network topology.

#subnet 10.152.187.0 netmask 255.255.255.0 {
#}

# This is a very basic subnet declaration.

#subnet 10.254.239.0 netmask 255.255.255.224 {
#  range 10.254.239.10 10.254.239.20;
#  option routers rtr-239-0-1.example.org, rtr-239-0-2.example.org;
#}

# This declaration allows BOOTP clients to get dynamic addresses,
# which we dont really recommend.

#subnet 10.254.239.32 netmask 255.255.255.224 {
#  range dynamic-bootp 10.254.239.40 10.254.239.60;
#  option broadcast-address 10.254.239.31;
#  option routers rtr-239-32-1.example.org;
#}

# A slightly different configuration for an internal subnet.
#subnet 10.5.5.0 netmask 255.255.255.224 {
#  range 10.5.5.26 10.5.5.30;
#  option domain-name-servers ns1.internal.example.org;
#  option domain-name internal.example.org;
#  option subnet-mask 255.255.255.224;
#  option routers 10.5.5.1;
#  option broadcast-address 10.5.5.31;
#  default-lease-time 600;
#  max-lease-time 7200;
#}

# Hosts which require special configuration options can be listed in
# host statements.   If no address is specified, the address will be
# allocated dynamically (if possible), but the host-specific information
# will still come from the host declaration.

#host passacaglia {
#  hardware ethernet 0:0:c0:5d:bd:95;
#  filename vmunix.passacaglia;
#  server-name toccata.fugue.com;
#}

# Fixed IP addresses can also be specified for hosts.   These addresses
# should not also be listed as being available for dynamic assignment.
# Hosts for which fixed IP addresses have been specified can boot using
# BOOTP or DHCP.   Hosts for which no fixed address is specified can only
# be booted with DHCP, unless there is an address range on the subnet
# to which a BOOTP client is connected which has the dynamic-bootp flag
# set.
#host fantasia {
#  hardware ethernet 08:00:07:26:c0:a5;
#  fixed-address fantasia.fugue.com;
#}

# You can declare a class of clients and then do address allocation
# based on that.   The example below shows a case where all clients
# in a certain class get addresses on the 10.17.224/24 subnet, and all
# other clients get addresses on the 10.0.29/24 subnet.

#class foo {
#  match if substring (option vendor-class-identifier, 0, 4) = SUNW;
#}

#shared-network 224-29 {
#  subnet 10.17.224.0 netmask 255.255.255.0 {
#    option routers rtr-224.example.org;
#  }
#  subnet 10.0.29.0 netmask 255.255.255.0 {
#    option routers rtr-29.example.org;
#  }
#  pool {
#    allow members of foo;
#    range 10.17.224.10 10.17.224.250;
#  }
#  pool {
#    deny members of foo;
#    range 10.0.29.10 10.0.29.230;
#  }
#}

#A1
subnet 10.16.4.128 netmask 255.255.255.248 {
    option routers 10.16.4.129;
    option broadcast-address 10.16.4.135;
}

#A2
subnet 10.16.4.0 netmask 255.255.255.128 {
    range 10.16.4.3 10.16.4.103;
    option routers 10.16.4.1;
    option broadcast-address 10.16.4.127;
    option domain-name-servers 10.16.4.130; 
    option domain-name-servers 192.168.122.1;
    default-lease-time 720;
    max-lease-time 3600;
}

#A3
subnet 10.16.0.0 netmask 255.255.252.0 {
    range 10.16.0.3 10.16.2.194;
    option routers 10.16.0.1;
    option broadcast-address 10.16.3.255;
    option domain-name-servers 10.16.4.130; 
    option domain-name-servers 192.168.122.1;
    default-lease-time 720;
    max-lease-time 3600;
}

#A6
subnet 10.16.12.0 netmask 255.255.254.0 {
    range 10.16.12.3 10.16.13.49;
    option routers 10.16.12.1;
    option broadcast-address 10.16.13.255;
    option domain-name-servers 10.16.4.130;
    option domain-name-servers 192.168.122.1;
    default-lease-time 720;
    max-lease-time 3600;
}

#A7
subnet 10.16.8.0 netmask 255.255.255.0 {
    range 10.16.8.3 10.16.8.205;
    option routers 10.16.8.1;
    option broadcast-address 10.16.8.255;
    option domain-name-servers 10.16.4.130;
    option domain-name-servers 192.168.122.1;
    default-lease-time 720;
    max-lease-time 3600;
}

#A8
subnet 10.16.9.0 netmask 255.255.255.248 {
    option routers 10.16.9.1;
    option broadcast-address 10.16.8.255;
}
' >  /etc/dhcp/dhcpd.conf

service isc-dhcp-server restart

iptables -A INPUT -p icmp -m connlimit --connlimit-above 3 --connlimit-mask 0 -j DROP