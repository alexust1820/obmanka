#!/bin/bash

echo "Backup is creating..."

backup_dir="/etc"

dest_dir="/opt/backup"

mkdir -p $dest_dir

tar -czf $dest_dir/$(hostname -s)-$(date +"%d.%m.zy").tgz $backup_dir

echo "Backup done!"