#!/bin/bash

#Variables

CONTROLLER0_IP=172.31.105.116
CONTROLLER1_IP=172.31.111.25

#nginx package check

if  !  dpkg -l | grep -q nginx*; then
	sudo apt update
	sudo apt install -y nginx
fi

sudo systemctl enable nginx
sudo mkdir -p /etc/nginx/tcpconf.d
echo "include /etc/nginx/tcpconf.d/*;" | sudo tee -a  /etc/nginx/nginx.conf

cat << EOF | sudo tee /etc/nginx/tcpconf.d/kubernetes.conf
stream {
    upstream kubernetes {
        server $CONTROLLER0_IP:6443;
        server $CONTROLLER1_IP:6443;
    }

    server {
        listen 6443;
        listen 443;
        proxy_pass kubernetes;
    }
}
EOF

sudo nginx -s reload

#Check if everything is ok at the end

curl -k https://localhost:6443/version
