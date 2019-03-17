#!/bin/bash
#在不同情况下恢复数据库

#如果想恢复第一次全量(感觉这个还是有问题的，不能写在一起，应该先--apply-log，再--copy-back，和下面恢复的一样)
xtrabackup --host=192.168.1.12 --port=3306 --user=root --password=123456 --datadir=/data/mysql/5.7.18-3306/data/ --databases="mysql performance_schema sys test" --prepare --apply-log-only --target-dir=/data/backups/base/
xtrabackup --host=192.168.1.12 --port=3306 --user=root --password=123456 --datadir=/data/mysql/5.7.18-3306/data/ --databases="mysql performance_schema sys test" --copy-back --force-non-empty-directories --target-dir=/data/backups/base/

#如果想恢复第一次增量（最后的一次--copy-back执行因为已经执行过日志，--apply-log-only没用了，不用加）
#xtrabackup --host=192.168.1.12 --port=3306 --user=root --password=123456 --datadir=/data/mysql/5.7.18-3306/data/ --databases="mysql performance_schema sys test" --prepare --apply-log-only --target-dir=/data/backups/base
#xtrabackup --host=192.168.1.12 --port=3306 --user=root --password=123456 --datadir=/data/mysql/5.7.18-3306/data/ --databases="mysql performance_schema sys test" --prepare --apply-log-only --target-dir=/data/backups/base --incremental-dir=/data/backups/inc1
#xtrabackup --host=192.168.1.12 --port=3306 --user=root --password=123456 --datadir=/data/mysql/5.7.18-3306/data/ --databases="mysql performance_schema sys test" --copy-back --force-non-empty-directories --target-dir=/data/backups/base/

#如果想恢复第二次增量
#xtrabackup --host=192.168.1.12 --port=3306 --user=root --password=123456 --datadir=/data/mysql/5.7.18-3306/data/ --databases="mysql performance_schema sys test" --prepare --apply-log-only --target-dir=/data/backups/base
#xtrabackup --host=192.168.1.12 --port=3306 --user=root --password=123456 --datadir=/data/mysql/5.7.18-3306/data/ --databases="mysql performance_schema sys test" --prepare --apply-log-only --target-dir=/data/backups/base --incremental-dir=/data/backups/inc1
#xtrabackup --host=192.168.1.12 --port=3306 --user=root --password=123456 --datadir=/data/mysql/5.7.18-3306/data/ --databases="mysql performance_schema sys test" --prepare --apply-log-only --target-dir=/data/backups/base --incremental-dir=/data/backups/inc2
#xtrabackup --host=192.168.1.12 --port=3306 --user=root --password=123456 --datadir=/data/mysql/5.7.18-3306/data/ --databases="mysql performance_schema sys test" --copy-back --force-non-empty-directories --target-dir=/data/backups/base/

cd /data/mysql/5.7.18-3306/data

chown -R polkitd:input ib_logfile0 ib_logfile1 ib_buffer_pool ibdata1 mysql performance_schema  sys test xtrabackup_info xtrabackup_master_key_id

docker start test-mysql-5.7.18-3306
