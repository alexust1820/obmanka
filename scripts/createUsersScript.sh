#!/bin/bash

hostname=$(cat /etc/hostname)
pass="P@ssw0rd"

if [[ $hostname == "CLI" || $hostname == "HQ-SRV" || $hostname == "HQ-R" ]]; then
	echo "create admin";
	useradd adm -m -c "Admin" -U;
	printf "$pass\n$pass\n" | passwd adm
fi

if [[ $hostname == "BR-SRV" || $hostname == "BR-R" ]]; then
	echo "create br-admin";
	useradd br-admin -m -c "Branch admin" -U;
	printf "$pass\n$pass\n" | passwd br-admin
fi

if [[ $hostname == "HQ-R" || $hostname == "BR-R" || $hostname == "BR-SRV" ]]; then
	echo "create net-admin";
	useradd net-admin -m -c "Network admin" -U;
	printf "$pass\n$pass\n" | passwd net-admin
fi
