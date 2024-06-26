
tar -xvzf apstra-cloud-services-edge_4.2.1_0.0.36_1.tar.gz

cd apstra-edge-0.0.36/

vi docker-compose-0.0.36.yml

mkdir apstra_edge

cp apstra-edge-0.0.36/docker-compose-0.0.36.yml apstra_edge/docker-compose.yml
cp apstra-edge-0.0.36/apstra-edge-container-0.0.36.tgz apstra_edge/

cd apstra_edge

#
sudo tee /apstra_edge/docker-compose.yml<<EOF
example
example test
EOF

# - REGISTRATION_KEY=<registration-code>
# - CLOUD_TERM=ep-term.ai.juniper.net

# read -p "Enter Your REGISTRATION_KEY: " KEY
# read -p "Enter Your Apstra_IP_Address: " IPA

docker load < apstra-edge-container-0.0.36.tgz

#
# vi docker-compose.yml
#- REGISTRATION_KEY=<registration-code>
#- CLOUD_TERM=ep-term.ai.juniper.net
# AOS_INSECURE_SKIP_VERIFY=true

cd /etc/ssl/certs
sudo cp ~/apstra-edge-0.0.36/ssl-keys/ep-term.ai.juniper.net.cer .

sudo chmod 644 ep-term.ai.juniper.net.cer

sudo update-ca-certificates

cd apstra_edge
docker compose up -d

docker compose down
docker compose up -d 
