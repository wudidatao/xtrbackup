#!/bin/bash

mkdir -R /data/backups/

echo "数据检查"
mysql -h192.168.1.12 -uroot -p123456 -e "select count(*) from test.student;"

echo "完全备份"
xtrabackup --host=192.168.1.12 --port=3306 --user=root --password=123456 --datadir=/data/mysql/5.7.18-3306/data/ --databases="mysql performance_schema sys test" --backup --target-dir=/data/backups/base

echo "数据检查"
mysql -h192.168.1.12 -uroot -p123456 -e "select count(*) from test.student;"

sleep 30s

echo "30秒后，第一次增量备份"
xtrabackup --host=192.168.1.12 --port=3306 --user=root --password=123456 --datadir=/data/mysql/5.7.18-3306/data/ --databases="mysql performance_schema sys test" --backup --target-dir=/data/backups/inc1 --incremental-basedir=/data/backups/base

echo "数据检查"
mysql -h192.168.1.12 -uroot -p123456 -e "select count(*) from test.student;"

sleep 30s

echo “30秒后，第二次增量备份”
xtrabackup --host=192.168.1.12 --port=3306 --user=root --password=123456 --datadir=/data/mysql/5.7.18-3306/data/ --databases="mysql performance_schema sys test" --backup --target-dir=/data/backups/inc2 --incremental-basedir=/data/backups/inc1

echo "数据检查"
mysql -h192.168.1.12 -uroot -p123456 -e "select count(*) from test.student;"
