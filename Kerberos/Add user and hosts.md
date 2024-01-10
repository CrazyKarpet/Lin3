## Add user and hosts 

```bash
kadmin.local
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
```

```bash
kinit
Password for root@LIN3.LOCAL:

klist
Ticket cache: KCM:0
Default principal: root@LIN3.LOCAL

Valid starting       Expires              Service principal
10. 01. 24 18:51:08  11. 01. 24 18:51:08  krbtgt/LIN3.LOCAL@LIN3.LOCAL
        renew until 10. 01. 24 18:51:08
```