#!/usr/bin/env bash
echo "Installing Consul startup script..."
sudo bash -c "cat >/etc/systemd/system/consul.service" << 'EOF'
[Unit]
Description=Consul agent
Requires=network-online.target
After=network-online.target

[Service]
EnvironmentFile=-/etc/default/consul
Restart=on-failure
ExecStart=/usr/local/bin/consul agent $CONSUL_FLAGS -config-dir=/etc/consul
ExecReload=/bin/kill -HUP $MAINPID
KillSignal=SIGTERM
User=consul
Group=consul

[Install]
WantedBy=multi-user.target
EOF

sudo chmod 0644 /etc/systemd/system/consul.service
