#!/bin/bash

if [[ -f "./.env" ]]; then
    source "./.env"
fi

apt-get -qq update > /dev/null
echo "Apt Updated"

curl -sSL https://get.docker.com | sh
echo "Docker installed"

sudo usermod -aG docker pi
echo "User access granted"

apt-get -qq install -y libffi-dev libssl-dev python3 python3-pip > /dev/null
echo "Dependencies installed"

pip3 -qq install docker-compose > /dev/null
echo "Docker compose installed"

docker-compose up -d --quiet-pull
echo "Containers started"

systemctl disable first-boot
rm -f /etc/systemd/system/first-boot.service ./.env

reboot
