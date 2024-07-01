# Apstra-vna
Apsta-Marvis Integration for AIOPS

Official site: <br>
https://www.juniper.net/documentation/us/en/software/apstra4.2/apstra-setup-edge/index.html  <br>

The only manual adjustment to this script is the REGISTRATION_KEY <br>
Get the code from Marvis Cloud and change it in the docker file in the Install script <be>

REGISTRATION_KEY= code  <be>

How to is on Step #3 on official guide: <br>
https://www.juniper.net/documentation/us/en/software/apstra4.2/apstra-setup-edge/apstra-cloud-services/topics/task/apstra-setup-the-edge.html  <br>

How to use this script. *On Apstra VM:
-
sudo apt update <br>
sudo apt -y install git <br>
git clone https://github.com/val3r1o/apstra-vna <br>
cd apstra-vna <br>
ls <br>
sudo chmod 755 install.sh <br>
ls <br>
-
#run the script <br>
./install.sh
