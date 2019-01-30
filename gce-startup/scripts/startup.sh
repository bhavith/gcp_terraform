#!/bin/bash
touch /opt/the-script-has-run

sudo apt-get -y update
sudo apt-get -y install nfs-common

sudo mkdir /mnt/filedir

sudo mount ${ipaddress}:/share1 /mnt/filedir