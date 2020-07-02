#!/bin/bash
yum update --skip-broken -y
yum install -y cloud-init wget open-vm-tools
/sbin/service rsyslog stop
/sbin/service auditd stop
package-cleanup --oldkernels --count=1
yum clean all
/usr/sbin/logrotate -f /etc/logrotate.conf
/bin/rm -f /var/log/*-???????? /var/log/*.gz
/bin/rm -f /var/log/dmesg.old
/bin/rm -rf /var/log/anaconda
/bin/cat /dev/null > /var/log/audit/audit.log
/bin/cat /dev/null > /var/log/wtmp
/bin/cat /dev/null > /var/log/lastlog
/bin/cat /dev/null > /var/log/grubby
/bin/sed -i '/^(HWADDR|UUID)=/d' /etc/sysconfig/network-scripts/ifcfg-e*
/bin/rm -rf /tmp/*
/bin/rm -rf /var/tmp/*
/bin/rm -f /etc/ssh/*key*
/bin/rm -f ~root/.bash_history
unset HISTFILE
/bin/rm -rf ~root/.ssh/
/bin/rm -f ~root/anaconda-ks.cfg
history -c
sys-unconfig
