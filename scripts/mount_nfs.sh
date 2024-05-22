#!/bin/bash
user=$(whoami)
if  [[ "$user" == "branch_admin" ]]; then
    echo 'root' | su -c "mount -t nfs4 10.2.0.10:/srv/nfs/Branch_Files /mnt/Branch_Files/"
fi

if [[ "$user" == "admin" ]]; then
    echo 'root' | su -c "mount -t nfs4 10.2.0.10:/srv/nfs/Admin_Files /mnt/Admin_Files"
fi

if [[ "$user" == "network_admin" ]]; then
    echo 'root' | su -c "mount -t nfs4 10.2.0.10:/srv/nfs/Network /mnt/Network"
fi

