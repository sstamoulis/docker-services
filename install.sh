#!/bin/bash

cp download_settings.env /etc/systemd/download_settings.env && \
echo "
PUID=$(id -u media)
PGID=$(id -g media)
TZ=$(cat /etc/timezone)" >> /etc/systemd/download_settings.env

export $(cat /etc/systemd/download_settings.env | xargs)

mkdir -p "${DOWNLOADS_PATH}/tv" && \
chown -R $PUID:$PGID "${DOWNLOADS_PATH}"

mkdir -p "${CONFIG_PATH}" && \
chown -R $PUID:$PGID "${CONFIG_PATH}"

for i in $(ls *.service *.mount); do
	systemctl disable $i
	cp $i \
		/etc/systemd/system/$i && \
	systemctl enable $i
done