#!/bin/bash

backup_dir=/data/backups
#备份周期天数
days=7
base_backup_time=`date "+%G-%m-%d"`
base_backup_dir=`find $backup_dir -name $base_backup_time -ctime -$days`
host_ip=192.168.1.12
port=3306
user=root
pass=123456
data_dir=/data/mysql/5.7.18-3306/data/
database_name="mysql performance_schema sys test"
