
wget -O apstra-cloud-services-edge_4.2.1_0.0.36_1.tar.gz "https://JUNIPER-DOWLOAD-LINK.tar.gz"

tar -xvzf apstra-cloud-services-edge_4.2.1_0.0.36_1.tar.gz

cd apstra-edge-0.0.36/

sudo vi docker-compose-0.0.36.yml

mkdir apstra_edge

sudo cp apstra-edge-0.0.36/docker-compose-0.0.36.yml apstra_edge/docker-compose.yml
sudo cp apstra-edge-0.0.36/apstra-edge-container-0.0.36.tgz apstra_edge/

cd apstra_edge

#read -p "Enter Your REGISTRATION_KEY: " KEY
#read -p "Enter Your Apstra_IP_Address: " IPA

#
#sudo tee /apstra_edge/docker-compose.yml <<EOF
#
#      - REGISTRATION_KEY=zgiDWJRKCcP0S8L06u5Gwby-NU1Lwu6Dyei62qnHx8jVYAAAj7Sgx2V6bv5KfwJ6
#EOF

# - REGISTRATION_KEY=<registration-code>
# - CLOUD_TERM=ep-term.ai.juniper.net
# - AOS_INSECURE_SKIP_VERIFY=true

docker load < apstra-edge-container-0.0.36.tgz
#-------------------------------------------------------------------------
# Replace certificate
# openssl req -newkey rsa:2048 -nodes -keyout nginx.key -x509 -days 1095 -out nginx.crt -addext extendedKeyUsage=serverAuth -addext subjectAltName=DNS:apstra.com,IP:10.28.176.3
#------------------------------------------------------------------------

cd /etc/ssl/certs
sudo cp ~/apstra-edge-0.0.36/ssl-keys/ep-term.ai.juniper.net.cer .
sudo chmod 644 ep-term.ai.juniper.net.cer
sudo update-ca-certificates

cd apstra_edge
docker compose up -d

sleep 5s # Waits 5 seconds.

docker compose down
docker compose up -d 
