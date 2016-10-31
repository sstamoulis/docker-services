#!/bin/bash
for i in $(ls *.service); do
	systemctl stop $i
done
docker ps -aq|xargs docker rm
./install.sh
for i in $(ls *.service); do
	systemctl start $i
done