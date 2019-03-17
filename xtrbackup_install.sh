#!/bin/bash

yum install https://repo.percona.com/yum/percona-release-latest.noarch.rpm
#mysql5.6备份
yum install percona-xtrabackup-2.3.10-1.el7.x86_64

#mysql5.7备份(亲测可用)
yum install percona-xtrabackup-24

#mysql8备份
wget https://www.percona.com/downloads/XtraBackup/Percona-XtraBackup-8.0.4/binary/redhat/7/x86_64/percona-xtrabackup-80-8.0.4-1.el7.x86_64.rpm
yum localinstall percona-xtrabackup-80-8.0.4-1.el7.x86_64.rpm
