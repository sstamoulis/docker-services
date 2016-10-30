#!/bin/bash

for i in $(ls *.service); do
	systemctl disable $i
	cp $i \
		/etc/systemd/system/$i && \
	systemctl enable $i
done
cp download_settings.env /etc/systemd/download_settings.env && \
echo "PUID=$(id -u media)
PGID=$(id -g media)
TZ=$(cat /etc/timezone)" >> /etc/systemd/download_settings.env