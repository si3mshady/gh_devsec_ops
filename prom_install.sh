#!/bin/bash

# Download Prometheus
PROMETHEUS_VERSION="2.30.3"
wget https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz
tar -xzf prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz
cd prometheus-${PROMETHEUS_VERSION}.linux-amd64

# Configure Prometheus
cat <<EOF > prometheus.yml
global:
  scrape_interval: 15s
scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
EOF

# Start Prometheus
nohup ./prometheus > /dev/null 2>&1 &

echo "Prometheus setup completed."