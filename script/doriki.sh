echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install nano
apt-get install netcat -y

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

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT