#!/bin/bash
cat << EOF > /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4 centos9-ks-01.lin3.local centos9-ks-01 lin3.local
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

EOF

systemctl start firewalld
firewall-cmd --add-service=kpasswd --permanent
firewall-cmd --add-service=kerberos --permanent
firewall-cmd --add-port=749/tcp --permanent
firewall-cmd --reload

hostnamectl set-hostname centos9-ks-01.lin3.local

yum install krb5-libs -y
yum install krb5-server -y
yum install krb5-workstation -y


cp  /etc/krb5.conf /etc/krb5.conf.bkp
cat << EOF > /etc/krb5.conf
# To opt out of the system crypto-policies configuration of krb5, remove the
# symlink at /etc/krb5.conf.d/crypto-policies which will not be recreated.
includedir /etc/krb5.conf.d/

[logging]
 default = FILE:/var/log/krb5libs.log
 kdc = FILE:/var/log/krb5kdc.log
 admin_server = FILE:/var/log/kadmind.log

[libdefaults]
 dns_lookup_realm = false
 ticket_lifetime = 24h
 renew_lifetime = 7d
 forwardable = true
 rdns = false
 pkinit_anchors = FILE:/etc/pki/tls/certs/ca-bundle.crt
 default_realm = LIN3.LOCAL
 default_ccache_name = KEYRING:persistent:%{uid}

[realms]
 LIN3.LOCAL = {
  supported_enctypes = aes256-cts-hmac-sha1-96:normal aes128-cts-hmac-sha1-96:normal
  kdc = centos9-ks-01.lin3.local
  admin_server = centos9-ks-01.lin3.local
 }

[domain_realm]
  .lin3.local = LIN3.LOCAL
  lin3.local = LIN3.LOCAL
EOF

cp  /var/kerberos/krb5kdc/kdc.conf /var/kerberos/krb5kdc/kdc.conf.bkp
cat << EOF > /var/kerberos/krb5kdc/kdc.conf
[kdcdefaults]
    kdc_ports = 88
    kdc_tcp_ports = 88
    spake_preauth_kdc_challenge = edwards25519

[realms]
 LIN3.LOCAL = {
  #master_key_type = aes256-cts
  acl_file = /var/kerberos/krb5kdc/kadm5.acl
  dict_file = /usr/share/dict/words
  admin_keytab = /var/kerberos/krb5kdc/kadm5.keytab
  supported_enctypes = aes256-cts:normal aes128-cts:normal des3-hmac-sha1:normal arcfour-hmac:normal camellia256-cts:normal camellia128-cts:normal des-hmac-sha1:normal des-cbc-md5:normal des-cbc-crc:normal
 }
EOF

cp /var/kerberos/krb5kdc/kadm5.acl /var/kerberos/krb5kdc/kadm5.acl.bkp
cat << EOF > /var/kerberos/krb5kdc/kadm5.acl
*/admin@LIN3.LOCAL      *
EOF

kdb5_util create -s

service krb5kdc start
systemctl enable krb5kdc  

service kadmin start
systemctl enable kadmin  
