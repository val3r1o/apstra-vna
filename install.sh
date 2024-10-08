cd 
sudo pip install gdown
sudo gdown https://drive.google.com/uc?id=1DDthM8Vz0S3T3E8HdJ0tG77bhm0hsQ4Z
sudo tar -xvzf apstra-cloud-services-edge_4.2.1_0.0.36_1.tar.gz

#cd apstra-edge-0.0.36/
#sudo vi docker-compose-0.0.36.yml
# cd
mkdir apstra_edge
sudo cp apstra-edge-0.0.36/docker-compose-0.0.36.yml apstra_edge/docker-compose.yml
sudo cp apstra-edge-0.0.36/apstra-edge-container-0.0.36.tgz apstra_edge/

cd apstra_edge

# read -p "Enter Your REGISTRATION_KEY: " KEY
# read -p "Enter Your Apstra_IP_Address: " IPA
#

# PLEASE CHANGE HERE BELOW THE REGISTRATION_KEY
sudo tee docker-compose.yml << EOF
version: '3.0'
volumes:
  apstra_edge_store:
services:
  apstra-edge:
    # Name of the edge container
    container_name: apstra-edge
    # The image to be used for the edge container
    image: apstra-edge:0.0.36
    # The restart policy for the container
    restart: always
    # pull_policy is set to always to ensure that the latest image is always used
    #pull_policy: always
    logging:
      driver: "json-file"
      options:
        max-size: "30m"
        max-file: "10"
    # List of volumes to be mounted to the container
    volumes:
      # Allows the container to access the host's SSL certificates
      - /etc/ssl/certs:/etc/ssl/certs
      # Allows the container to access the host's /etc/hosts file
      - /etc/hosts:/etc/hosts
      # Allows apstra-edge to store auth data retrieved from the cloud during registration
      # This volume is used to persist the data across container restarts
      # User must backup this volume to avoid data loss
      - apstra_edge_store:/var/lib/aos-edge
    network_mode: "host"
    environment:
      # The registration key of the apstra-edge registered in the PAPI/UI
      # mandatory <<<copy the ID here from ADOPT APSTRA EDGE>>>
      - REGISTRATION_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      # The hostname of the cloud endpoint, EPTerm
      # mandatory
      - CLOUD_TERM=ep-term.ai.juniper.net
      - AOS_INSECURE_SKIP_VERIFY=true
EOF

#check
# sudo cat docker-compose.yml

sudo chmod 755 apstra-edge-container-0.0.36.tgz
sudo docker load < apstra-edge-container-0.0.36.tgz
#-------------------------------------------------------------------------
# Replace certificate
# sudo openssl req -newkey rsa:2048 -nodes -keyout nginx.key -x509 -days 1095 -out nginx.crt -addext extendedKeyUsage=serverAuth -addext subjectAltName=DNS:apstra.com,IP:10.28.176.3
# sudo openssl x509 -in nginx.crt -inform PEM -outform PEM -out 10.28.176.3_ca.cert.pem -days 1095
# sudo cp 10.28.176.3_ca.cert.pem /etc/ssl/certs
#------------------------------------------------------------------------

cd /etc/ssl/certs
sudo cp ~/apstra-edge-0.0.36/ssl-keys/ep-term.stage.ai.juniper.net.cer .
sudo chmod 644 ep-term.stage.ai.juniper.net.cer
sudo update-ca-certificates

cd
cd apstra_edge
sudo chmod 755 docker-compose.yml
docker compose up -d

sleep 5s # Waits 5 seconds.

docker compose down
docker compose up -d 
