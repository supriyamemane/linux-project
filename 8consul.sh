#!/usr/bin/env bash

#Enable and start Consul services on each node
chmod 0755 /etc/consul/
chmod -R 0755 /opt/consul/
sudo chown -R consul:consul /opt/consul 
sudo systemctl enable consul.service
sudo systemctl start consul

