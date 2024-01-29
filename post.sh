#!/bin/bash
set -e
sudo echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections


sudo echo "Creating Nomad files & directories..."
sudo mkdir -p /opt/nomad/data/plugins
sudo mkdir -p /etc/nomad.d 
sudo chmod 700 /etc/nomad.d
sudo mv /tmp/license.hclic /etc/nomad.d/license.hclic
sudo mv /tmp/nomad.service /opt/nomad.service

sudo mv /tmp/nomad-client.hcl /opt/nomad-client.hcl
sudo mv /tmp/nomad-server.hcl /opt/nomad-server.hcl

sudo echo "Installing Docker..."
sudo curl -fsSL https://get.docker.com -o install-docker.sh
sudo sh install-docker.sh
sudo echo "Done!"

sudo echo "Install unzip"
sudo apt-get update
sudo apt-get install -y unzip

sudo echo "Creating Nomad user"
sudo useradd --system --home /etc/nomad.d --shell /bin/false nomad

# sudo echo "Installing Podman..."
# sudo touch /etc/{subgid,subuid}
# sudo usermod --add-subuids 100000-165535 --add-subgids 100000-165535 ${OS_USER}
# sudo grep ${OS_USER} /etc/subuid /etc/subgid
# sudo apt-get install -y podman
# sudo podman system service -t 0 &
# sudo echo "Done!"

sudo echo "Installing Nomad"
sudo curl --silent --remote-name "https://releases.hashicorp.com/nomad/${NOMAD_VERSION}+ent/nomad_${NOMAD_VERSION}+ent_linux_amd64.zip"
sudo unzip "nomad_${NOMAD_VERSION}+ent_linux_amd64.zip"
sudo chown root:root nomad
sudo mv ./nomad /usr/local/bin

sudo echo "Done!"