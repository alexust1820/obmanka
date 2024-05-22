#!/bin/bash
dnf install clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd
sed -i -e "s/database.clamav.net/packages.microsoft.com\/clamav/" /etc/freshclam.conf
freshclam
systemctl enable clamav-freshclam --now
sed -i -e "s/^Example/#Example/" /etc/clamd.d/scan.conf
sed -i -e "s/#LocalSocket /LocalSocket /" /etc/clamd.d/scan.conf
mv /usr/lib/systemd/system/clamd@.service /usr/lib/systemd/system/clamd.service
sed -i -e "s/%i.conf/scan.conf/" /usr/lib/systemd/system/clamd.service
systemctl start clamd.service
systemctl enable clamd.service