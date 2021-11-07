#!/bin/bash
apt-get update -y
apt-get install -y ppp pptpd
echo "localip 172.16.11.1" | tee -a /etc/pptpd.conf
echo "remoteip 172.16.11.11-20" | tee -a /etc/pptpd.conf
echo "ms-dns 8.8.8.8" | tee -a /etc/ppp/pptpd-options
echo "ms-dns 8.8.4.4" | tee -a /etc/ppp/pptpd-options
echo "masbek    pptpd   masbek    *" | tee -a /etc/ppp/chap-secrets
/etc/init.d/pptpd restart
echo "net.ipv4.ip_forward=1" | tee -a /etc/sysctl.conf
sysctl -p
iptables -t nat -A POSTROUTING -j MASQUERADE
iptables -I INPUT -s 172.16.11.0/24 -i ppp0 -j ACCEPT
iptables -A FORWARD -i eth0 -j ACCEPT

wget -q -O /usr/bin/tambah-user "https://github.com/bakhtiyarsierad/setup-PPTP-auto-installer/blob/main/adduser.sh"
chmod +x /usr/bin/tambah-user
