#!/bin/bash

echo "Backup is creating..."
backup_dir="/etc"
dest_dir="/opt/backup"
if [ ! -d "$dest_dir" ]; then
    mkdir -p $dest_dir
fi
tar -czf $dest_dir/$(hostname -s)-$(date +"%d.%m.zy").tgz $backup_dir
echo "Backup done!"
