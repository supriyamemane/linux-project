#!/usr/bin/env bash


#Consul config - save to /etc/consul/config.json replace bash variables with installation specific details

sudo mkdir -pm 0600 /etc/consul

sudo bash -c "cat >/etc/consul/config.json" << EOF

{
  "node_name": "$(hostname)",
  "data_dir": "/opt/consul/data",
  "ui": true,
  "client_addr": "0.0.0.0",
  "leave_on_terminate": false,
  "skip_leave_on_interrupt": true,
  "datacenter": "RBC_SAI",
  "server": true,
  "bootstrap_expect": 5,
  "retry_join": ["10.47.3.234","10.47.3.237","10.47.3.238","10.47.3.236"]
}

EOF



