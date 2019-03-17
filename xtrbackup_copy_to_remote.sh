#!/bin/bash

. ./var.sh

scp -r $backup_dir/* root@$remote_ip:$backup_dir
