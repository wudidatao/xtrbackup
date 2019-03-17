#!/bin/bash
#关闭数据库并模拟删除数据库部分数据

docker stop test-mysql-5.7.18-3306

cd /data/mysql/5.7.18-3306/data/

rm ib_logfile0 ib_logfile1 ibdata1 ib_buffer_pool mysql/ performance_schema/ sys/ test/ xtrabackup_info xtrabackup_binlog_pos_innodb xtrabackup_master_key_id -rf
