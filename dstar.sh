#!/bin/bash

cd /home/pi

sudo apt install -y git-core debhelper cmake libprotobuf-dev protobuf-compiler libcodecserver-dev
git clone https://github.com/szechyjs/mbelib.git
cd mbelib
dpkg-buildpackage
cd ..
sudo dpkg -i libmbe1_1.3.0_*.deb libmbe-dev_1.3.0_*.deb

git clone https://github.com/knatterfunker/codecserver-softmbe.git
cd codecserver-softmbe
dpkg-buildpackage
cd ..
sudo dpkg -i codecserver-driver-softmbe_0.0.1_*.deb

sudo echo '[device:softmbe]' >> /etc/codecserver/codecserver.conf
sudo echo 'driver=softmbe' >> /etc/codecserver/codecserver.conf

sudo systemctl restart codecserver
sudo systemctl status codecserver

sudo systemctl restart openwebrx
sudo systemctl status openwebrx