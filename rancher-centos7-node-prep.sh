#!/bin/bash
# Needed by all nodes
/usr/bin/firewall-cmd --permanent --add-port=2376/tcp
/usr/bin/firewall-cmd --permanent --add-port=4789/udp
/usr/bin/firewall-cmd --permanent --add-port=8472/udp
/usr/bin/firewall-cmd --permanent --add-port=9099/tcp
/usr/bin/firewall-cmd --permanent --add-port=10250/tcp
# Needed by etcd nodes only
/usr/bin/firewall-cmd --permanent --add-port=2379/tcp
/usr/bin/firewall-cmd --permanent --add-port=2380/tcp
# Needed by worker nodes only
/usr/bin/firewall-cmd --permanent --add-port=22/tcp
# Needed by control nodes only
/usr/bin/firewall-cmd --permanent --add-port=6443/tcp
# Needed by control and worker nodes
/usr/bin/firewall-cmd --permanent --add-port=80/tcp
/usr/bin/firewall-cmd --permanent --add-port=443/tcp
/usr/bin/firewall-cmd --permanent --add-port=10254/tcp
/usr/bin/firewall-cmd --permanent --add-port=30000-32767/tcp
/usr/bin/firewall-cmd --permanent --add-port=30000-32767/udp
/usr/bin/firewall-cmd --reload
echo -e 'net.bridge.bridge-nf-call-ip6tables = 1\nnet.bridge.bridge-nf-call-iptables = 1\n'>/etc/sysctl.d/10-rancher.conf
sysctl --system
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
setenforce 0
curl https://releases.rancher.com/install-docker/19.03.sh | sh
systemctl enable docker
echo "run hostnamectl with your FQDN (change this to your hostname)"
echo "hostnamectl set-hostname myhostname.mycompany.com"
echo "now you must reboot"