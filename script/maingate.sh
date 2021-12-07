echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install nano
apt-get install netcat -y

# untuk testing firewall = nmap -p 80 10.16.4.130