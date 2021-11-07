#!/bin/bash
apt-get update -y
apt-get install -y ppp pptpd
echo "localip 172.16.11.1" | tee -a /etc/pptpd.conf
echo "remoteip 172.16.11.11-20" | tee -a /etc/pptpd.conf
echo "ms-dns 8.8.8.8" | tee -a /etc/ppp/pptpd-options
echo "ms-dns 8.8.4.4" | tee -a /etc/ppp/pptpd-options
echo "fawzya    pptpd   1234567    *" | tee -a /etc/ppp/chap-secrets
/etc/init.d/pptpd restart
echo "net.ipv4.ip_forward=1" | tee -a /etc/sysctl.conf
sysctl -p
iptables -t nat -A POSTROUTING -j MASQUERADE
iptables -I INPUT -s 172.16.11.0/24 -i ppp0 -j ACCEPT
iptables -A FORWARD -i eth0 -j ACCEPT

wget -q -O /usr/bin/tambah-user "script.fawzya.net/PPTP/adduser.sh"
chmod +x /usr/bin/tambah-user
