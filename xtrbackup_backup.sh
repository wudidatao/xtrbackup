
#!/bin/bash

#标准本地备份
backup_dir=/data/backups
days=7
base_backup_time=`date "+%G-%m-%d"`
base_backup_dir=`find $backup_dir -name $base_backup_time -ctime -$days`
host_ip=192.168.1.12
port=3306
user=root
pass=123456
data_dir=/data/mysql/5.7.18-3306/data/
database_name="mysql performance_schema sys test"


if [ ! -d $backup_dir ]; then
    mkdir -p $backup_dir
fi

#过期数据清理
find $backup_dir -name "*" -ctime +7 -print -exec rm -rf {} \;

if [ -z $base_backup_dir ]; then
    base_backup_dir=$backup_dir/$base_backup_time
fi

if [ ! -d  $base_backup_dir ]; then
    mkdir -p $backup_dir/$base_backup_time
fi


if [ ! -d $base_backup_dir/base ]; then
    xtrabackup --host=$host_ip --port=$port --user=$user --password=$pass --datadir=$data_dir --databases="$database_name" --backup --target-dir=$base_backup_dir/base
else
   cd $base_backup_dir
   for n in `seq $days`;
   do
       if [ $n = 1 ]; then
           if [ ! -d $base_backup_dir/inc$n ];then
               xtrabackup --host=$host_ip --port=$port --user=$user --password=$pass --datadir=$data_dir --databases="$database_name" --backup --target-dir=$base_backup_dir/inc$n --incremental-basedir=$base_backup_dir/base
               break
           fi
       else
           if [ ! -d $base_backup_dir/inc$n ];then
               xtrabackup --host=$host_ip --port=$port --user=$user --password=$pass --datadir=$data_dir --databases="$database_name" --backup --target-dir=$base_backup_dir/inc$n --incremental-basedir=$base_backup_dir/inc`expr $n - 1`
               break
           fi
       fi
   done
fi
