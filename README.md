# setup-PPTP-auto-installer
Auto Installer VPN PPTP

System Test On
- OS Ubuntu 18.04
- VPS KVM


Tambah user Manual
#nano /etc/ppp/chap-secrets
isi username spasi protocol spasi password

setelah save restart service dengan command berikut
#/etc/init.d/pptpd restart

