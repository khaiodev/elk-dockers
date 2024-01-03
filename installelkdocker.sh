#!/bin/sh -e

#Definido vm.max_map_count e criando serviço rc.local
echo "sysctl -w vm.max_map_count=262144" > /etc/rc.local
chmod +x /etc/rc.local
systemctl daemon-reload
systemctl start rc-local

#Instalar ELK Stack em Docker
sysctl -w vm.max_map_count=262144
git clone https://github.com/khaiodev/elk-docker.git
cd elastic-docker
docker-compose -f docker-compose.setup.yml run --rm keystore
docker-compose -f docker-compose.setup.yml run --rm certs
docker-compose up -d

exit 0