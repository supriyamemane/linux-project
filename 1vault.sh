#!/usr/bin/env bash

VAULT_USER="vault"
VAULT_COMMENT="Vault Server"
VAULT_GROUP="vault"
VAULT_HOME="/srv/vault"


# Download Vault from releases.hashicorp.com
cd /tmp/all_vault_installers
echo "Installing Vault"
sudo chmod +x vault
sudo mv vault /usr/local/bin
sudo chmod 0755 /usr/local/bin/vault
sudo chown root:root /usr/local/bin/vault

# Grant mlock syscall to vault executable
sudo setcap cap_ipc_lock=+ep /usr/local/bin/vault

# Create Vault config diretory
sudo mkdir -pm 0600 /etc/vault

# Check vault output
echo "Installed Vault version is $(/usr/local/bin/vault --version)"

sudo groupadd --force --system ${VAULT_GROUP}

if ! getent passwd vault >/dev/null ; then
	  sudo adduser \
		--system \
		--gid ${VAULT_GROUP} \
		--home ${VAULT_HOME} \
		--no-create-home \
		--comment "${VAULT_COMMENT}" \
		--shell /bin/false \
		$VAULT_USER  >/dev/null
fi
