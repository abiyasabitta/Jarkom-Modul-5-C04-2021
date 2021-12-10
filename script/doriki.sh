echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install nano
apt-get install netcat -y
apt-get install bind9 -y

iptables -A INPUT -p icmp -m connlimit --connlimit-above 3 --connlimit-mask 0 -j DROP

#4
iptables -A INPUT -s 10.16.4.0/25 -m time --timestart 07:00 --timestop 15:00 --weekdays Mon,Tue,Wed,Thu -j ACCEPT
iptables -A INPUT -s 10.16.4.0/25 -j REJECT
iptables -A INPUT -s 10.16.0.0/22 -m time --timestart 07:00 --timestop 15:00 --weekdays Mon,Tue,Wed,Thu -j ACCEPT
iptables -A INPUT -s 10.16.0.0/22 -j REJECT

#5
iptables -A INPUT -s 10.16.12.0/23 -m time --timestart 15:01 --timestop 23:59 -j ACCEPT
iptables -A INPUT -s 10.16.12.0/23 -m time --timestart 00:00 --timestop 06:59 -j ACCEPT
iptables -A INPUT -s 10.16.8.0/24 -m time --timestart 15:01 --timestop 23:59 -j ACCEPT
iptables -A INPUT -s 10.16.8.0/24 -m time --timestart 00:00 --timestop 06:59 -j ACCEPT
iptables -A INPUT -s 10.16.12.0/23 -j REJECT
iptables -A INPUT -s 10.16.8.0/24 -j REJECT

#6
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

echo '
//
// Do any local configuration here
//

// Consider adding the 1918 zones here, if they are not used in your
// organization
//include "/etc/bind/zones.rfc1918";

zone "jarkomC04.com" {
        type master;
        file "/etc/bind/jarkom/jarkomC04.com";
};' > /etc/bind/named.conf.local

mkdir /etc/bind/jarkom
cp /etc/bind/db.local /etc/bind/jarkom/jarkomC04.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     jarkomC04.com. root.jarkomC04.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      jarkomC04.com.
@       IN      A       10.16.4.128' > /etc/bind/jarkom/jarkomC04.com

service bind9 restart