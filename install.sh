cd 
sudo pip install gdown
sudo gdown sudo gdown https://drive.google.com/uc?id=1CssCIL6hOb2VmvZJgVUU2yELPUeFWdDr

mkdir apstra_edge
sudo cp docker-compose.yml apstra_edge/docker-compose.yml
sudo cp edge-0.0.59.tar apstra_edge/edge-0.0.59.tar
sudo cp ep-term.stage.ai.juniper.net.cer /etc/ssl/certs/ep-term.stage.ai.juniper.net.cer

cd apstra_edge

#
# read -p "Enter Your REGISTRATION_KEY: " KEY
# read -p "Enter Your Apstra_IP_Address: " IPA
#

sudo chmod 755 edge-0.0.59.tar
sudo docker load < edge-0.0.59.tar

#-------------------------------------------------------------------------
# Replace certificate
# sudo openssl req -newkey rsa:2048 -nodes -keyout nginx.key -x509 -days 1095 -out nginx.crt -addext extendedKeyUsage=serverAuth -addext subjectAltName=DNS:apstra.com,IP:10.28.176.3
# sudo openssl x509 -in nginx.crt -inform PEM -outform PEM -out 10.28.176.3_ca.cert.pem -days 1095
# sudo cp 10.28.176.3_ca.cert.pem /etc/ssl/certs
#------------------------------------------------------------------------

cd /etc/ssl/certs
sudo chmod 644 ep-term.stage.ai.juniper.net.cer
sudo update-ca-certificates

cd
cd apstra-vna
cd apstra_edge
sudo chmod 755 docker-compose.yml
docker compose up -d

sleep 5s # Waits 5 seconds.

docker compose down
docker compose up -d 
