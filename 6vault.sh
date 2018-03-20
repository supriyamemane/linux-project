#!/usr/bin/env bash

echo "Configuring Vault environment..."
sudo bash -c "cat >/etc/profile.d/vault.sh" << VAULTENV
export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_SKIP_VERIFY=true
VAULTENV
sudo chmod 755 /etc/profile.d/vault.sh
