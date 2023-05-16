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

# Install Grafana
sudo apt-get update
sudo apt-get install -y apt-transport-https
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee /etc/apt/sources.list.d/grafana.list
sudo apt-get update
sudo apt-get install -y grafana

# Configure Grafana
sudo grafana-cli plugins install grafana-piechart-panel
sudo systemctl start grafana-server
sudo systemctl enable grafana-server

# Configure Prometheus as a data source in Grafana
sleep 5 # Wait for Grafana to start
curl -u admin:admin -XPOST -H 'Content-Type: application/json' \
  -d '{"name":"Prometheus","type":"prometheus","url":"http://localhost:9090","access":"proxy","basicAuth":false}' \
  http://localhost:3000/api/datasources

echo "Prometheus and Grafana installation and configuration completed."
