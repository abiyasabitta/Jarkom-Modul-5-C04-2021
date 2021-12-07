echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install nano

iptables -A INPUT -p icmp -m connlimit --connlimit-above 3 --connlimit-mask 0 -j DROP