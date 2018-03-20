#!/usr/bin/env bash
echo "Installing Vault startup script..."
sudo bash -c "cat >/etc/systemd/system/vault.service" << 'VAULTSVC'
[Unit]
Description=Vault server
Requires=basic.target network.target
After=basic.target network.target consul.service

[Service]
User=vault
Group=vault
PrivateDevices=yes
PrivateTmp=yes
ProtectSystem=full
ProtectHome=read-only
SecureBits=keep-caps
Capabilities=CAP_IPC_LOCK+ep
CapabilityBoundingSet=CAP_SYSLOG CAP_IPC_LOCK
NoNewPrivileges=yes
Environment=GOMAXPROCS=1
ExecStart=/usr/local/bin/vault server -config=/etc/vault/
KillSignal=SIGINT
TimeoutStopSec=30s
Restart=on-failure
StartLimitInterval=60s
StartLimitBurst=3
VAULTSVC
sudo chmod 0644 /etc/systemd/system/vault.service

