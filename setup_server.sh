#!/bin/bash
sudo apt update
sudo apt upgrade
sudo add-apt-repository ppa:kelleyk/emacs
sudo apt -y install git emacs26 htop python3-pip

# Install influxdb
wget -qO- https://repos.influxdata.com/influxdb.key | sudo apt-key add -
source /etc/lsb-release
echo "deb https://repos.influxdata.com/${DISTRIB_ID,,} ${DISTRIB_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
sudo apt install influxdb
sudo systemctl unmask influxdb.service
sudo systemctl start influxdb

sudo apt install influxdb-client
