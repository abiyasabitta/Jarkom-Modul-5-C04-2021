echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install nano

apt-get install isc-dhcp-server -y

echo 'INTERFACES="eth0"' > /etc/default/isc-dhcp-server

echo 'subnet 10.16.4.0 netmask 255.255.255.128 {
    range 10.16.4.2 10.16.4.126;
    option routers 10.16.4.1;
    option broadcast-address 10.16.4.127;
    option domain-name-servers 10.16.4.130;
    default-lease-time 720;
    max-lease-time 7200;
}

subnet 10.16.0.0 netmask 255.255.252.0 {
    range 10.16.0.2 10.16.3.254;
    option routers 10.16.0.1;
    option broadcast-address 10.16.3.255;
    option domain-name-servers 10.16.4.130;
    default-lease-time 720;
    max-lease-time 7200;
}

subnet 10.16.12.0 netmask 255.255.254.0{
    range 10.16.12.2 10.16.13.254;
    option routers 10.16.12.1;
    option broadcast-address 10.16.13.255;
    option domain-name-servers 10.16.4.130;
    default-lease-time 720;
    max-lease-time 7200;
}

subnet 10.16.8.0 netmask 255.255.255.0{
    range 10.16.8.2 10.16.8.254;
    option routers 10.16.8.1;
    option broadcast-address 10.16.8.255;
    option domain-name-servers 10.16.4.130;
    default-lease-time 720;
    max-lease-time 7200;
}
'> /etc/dhcp/dhcpd.conf

service isc-dhcp-server restart