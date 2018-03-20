#!/usr/bin/env bash
echo "Create Vault config without TLS (good for development/POC)..."
sudo bash -c "cat >/etc/vault/config.hcl" << 'EOF'

backend "consul" {
  address = "127.0.0.1:8500"
  path = "vault"
}
listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = 1
}
ui = true
EOF
sudo chmod -R 0744 /etc/vault
sudo chmod 0644 /etc/systemd/system/consul.service
