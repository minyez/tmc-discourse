#!/usr/bin/env bash
source custom.sh

# deploy clash for GIT

sudo git clone https://github.com/discourse/discourse_docker.git /var/discourse
cd /var/discourse
# curl is installed by compile_ssl_git.sh
sudo apt install -y apt-transport-https ca-certificates software-properties-common #curl 
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic test"
sudo apt update
sudo apt upgrade
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

exit
# move app.yml to discourse and check if plain install works

sudo apt-get install -y nginx

sudo rm /etc/nginx/sites-enabled/default
sudo echo > /etc/nginx/sites-enabled/discourse << EOF
server {
        listen 80;
        server_name $discdomain;
        return 301 https://$discdomain$request_uri;
}
server {
        listen 443 ssl spdy;
        server_name $discdomain;
        ssl_certificate /etc/letsencrypt/live/$discdomain/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/$discdomain/privkey.pem;
        ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
        ssl_ciphers 'ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:ECDHE-RSA-DES-CBC3-SHA:ECDHE-ECDSA-DES-CBC3-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:AES:CAMELLIA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!aECDH:!EDH-DSS-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!KRB5-DES-CBC3-SHA';
        ssl_prefer_server_ciphers on;
        location / {
                proxy_pass      http://$discdomain:$port/;
                proxy_read_timeout      90;
                proxy_redirect  http://$discdomain:$port/ https://$discdomain;
        }
}
EOF

# refresh Letsencrypt
#certbot renew # --dry-run
