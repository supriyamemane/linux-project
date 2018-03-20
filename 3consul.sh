#!/usr/bin/env bash
set -x

CONSUL_USER="consul"
CONSUL_COMMENT="Consul Server"
CONSUL_GROUP="consul"
CONSUL_HOME="/srv/consul"

#######################################
# CONSUL INSTALL
#######################################

cd /tmp/all_vault_installers
echo "Installing Consul"
sudo chmod +x consul
sudo mv consul /usr/local/bin
sudo chmod 0755 /usr/local/bin/consul
sudo chown root:root /usr/local/bin/consul

# Create Consul config diretory
sudo mkdir -pm 0600 /etc/consul.d

# Create Consul directories
sudo mkdir -pm 0600 /opt/consul
sudo mkdir -p /opt/consul/data

# Check Consul output
echo "Installed Consul version is $(consul --version)"

#######################################
# DNSMASQ INSTALL
#######################################

# Install Dnsmasq packages
echo "Installing Dnsmasq"
sudo yum install -q -y dnsmasq

echo "Configuring Dnsmasq..."
sudo sh -c 'echo "server=/consul/127.0.0.1#8600" >> /etc/dnsmasq.d/consul'
sudo sh -c 'echo "listen-address=127.0.0.1" >> /etc/dnsmasq.d/consul'
sudo sh -c 'echo "bind-interfaces" >> /etc/dnsmasq.d/consul'

echo "Restarting dnsmasq..."
sudo service dnsmasq restart

echo "dnsmasq installation complete."

groupadd --force --system ${CONSUL_GROUP}

if ! getent passwd consul >/dev/null ; then
adduser \
  --system \
  --gid ${CONSUL_GROUP} \
  --home ${CONSUL_HOME} \
  --no-create-home \
  --comment "${CONSUL_COMMENT}" \
  --shell /bin/false \
  $CONSUL_USER  >/dev/null
fi

