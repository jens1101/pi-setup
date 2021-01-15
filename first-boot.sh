#!/bin/bash

if [[ -f "./.env" ]]; then
    source "./.env"
fi

apt-get -qq update > /dev/null
echo "Apt Updated"

curl -sSL https://get.docker.com | sh
echo "Docker installed"

apt-get -qq install -y libffi-dev libssl-dev python3 python3-pip > /dev/null
echo "Dependencies installed"

pip3 -qq install docker-compose > /dev/null
echo "Docker compose installed"

docker-compose up -d --quiet-pull
echo "Containers started"

systemctl disable first-boot
echo "First boot service disabled"
