#!/bin/bash
#使用binlog恢复数据库到指定时间点

binlog_filename=`cat /data/mysql/5.7.18-3306/data/xtrabackup_binlog_pos_innodb | awk '{print $1}'`
echo $binlog_filename

binlog_position=`cat /data/mysql/5.7.18-3306/data/xtrabackup_binlog_pos_innodb | awk '{print $2}'`
echo $binlog_position

mysqlbinlog --skip-gtids --start-position=$binlog_position /data/mysql/5.7.18-3306/data/$binlog_filename | mysql -h192.168.1.12 -uroot -p123456
