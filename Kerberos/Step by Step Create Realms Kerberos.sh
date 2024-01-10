## Step by Step Create Realms Kerberos 

systemctl start firewalld
firewall-cmd --add-service=kpasswd --permanent
firewall-cmd --add-service=kerberos --permanent
firewall-cmd --add-port=749/tcp --permanent
firewall-cmd --reload


tail -n +2 "/etc/hosts"


echo 'PAIN & GAIN' | sed 's/PAIN\s&\sGAIN/P\&G/g'

[root@centos9-ks-01 ~]# nano /etc/hosts

[root@centos9-ks-01 ~]# nano /etc/hostname

[root@centos9-ks-01 ~]# hostnamectl set-hostname centos9-ks-01.lin3.local

[root@centos9-ks-01 ~]# hostname
centos9-ks-01.lin3.local
[root@centos9-ks-01 ~]# yum install krb5-libs
[root@centos9-ks-01 ~]# yum install krb5-server
[root@centos9-ks-01 ~]# yum install krb5-workstation

[root@centos9-ks-01 ~]# nano /etc/hosts
[root@centos9-ks-01 ~]# cat /etc/hostname
centos9-ks-01.lin3.local

[root@centos9-ks-01 ~]# nano /etc/hosts
[root@centos9-ks-01 ~]# nano /etc/resolv.conf

[root@centos9-ks-01 ~]# cp  /etc/krb5.conf /etc/krb5.conf.bkp
[root@centos9-ks-01 ~]# nano  /etc/krb5.conf

[root@centos9-ks-01 ~]# cp  /var/kerberos/krb5kdc/kdc.conf /var/kerberos/krb5kdc/kdc.conf.bkp
[root@centos9-ks-01 ~]# nano /var/kerberos/krb5kdc/kdc.conf

[root@centos9-ks-01 ~]# nano /var/kerberos/krb5kdc/kadm5.acl

[root@centos9-ks-01 ~]# kdb5_util create -s

[root@centos9-ks-01 ~]# service krb5kdc start
[root@centos9-ks-01 ~]# service kadmin start

[root@centos9-ks-01 ~]# kadmin.local
Authenticating as principal root/admin@LIN3.LOCAL with password.
kadmin.local:  addprinc host/centos9-ks-01.lin3.local
No policy specified for host/centos9-ks-01.lin3.local@LIN3.LOCAL; defaulting to no policy
Enter password for principal "host/centos9-ks-01.lin3.local@LIN3.LOCAL":
Re-enter password for principal "host/centos9-ks-01.lin3.local@LIN3.LOCAL":
Principal "host/centos9-ks-01.lin3.local@LIN3.LOCAL" created.

kadmin.local:  addprinc root
No policy specified for root@LIN3.LOCAL; defaulting to no policy
Enter password for principal "root@LIN3.LOCAL":
Re-enter password for principal "root@LIN3.LOCAL":
Principal "root@LIN3.LOCAL" created.

kadmin.local:  ktadd -k /etc/krb5.keytab host/centos9-ks-01.lin3.local
Entry for principal host/centos9-ks-01.lin3.local with kvno 2, encryption type aes256-cts-hmac-sha1-96 added to keytab WRFILE:/etc/krb5.keytab.
Entry for principal host/centos9-ks-01.lin3.local with kvno 2, encryption type aes128-cts-hmac-sha1-96 added to keytab WRFILE:/etc/krb5.keytab.
kadmin.local:  exit

[root@centos9-ks-01 ~]# kinit
Password for root@LIN3.LOCAL:

[root@centos9-ks-01 ~]# klist
Ticket cache: KCM:0
Default principal: root@LIN3.LOCAL

Valid starting       Expires              Service principal
10. 01. 24 18:51:08  11. 01. 24 18:51:08  krbtgt/LIN3.LOCAL@LIN3.LOCAL
        renew until 10. 01. 24 18:51:08



KRB5_TRACE=/dev/stdout kinit louc