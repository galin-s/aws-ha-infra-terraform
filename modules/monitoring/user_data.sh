#!/bin/bash

yum update -y
amazon-linux-extras install docker -y
service docker start
systemctl enable docker

# Install docker-compose
curl -L "https://github.com/docker/compose/releases/download/v2.21.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Add alert rule
mkdir -p /opt/prometheus/rules

cat <<EOF > /opt/prometheus/rules/alert_rules.yml
groups:
  - name: node_alerts
    rules:
      - alert: HighCPUUsage
        expr: 100 - (avg by(instance) (rate(node_cpu_seconds_total{mode="idle"}[2m])) * 100) > 80
        for: 2m
        labels:
          severity: warning
        annotations:
          summary: "High CPU usage on {{ \$labels.instance }}"
          description: "CPU usage has been above 80% for more than 2 minutes."
EOF

# Add Prometheus config
mkdir -p /opt/prometheus

cat <<EOF > /opt/prometheus/prometheus.yml
global:
  scrape_interval: 15s

rule_files:
  - /opt/prometheus/rules/alert_rules.yml

scrape_configs:
  - job_name: ec2

    ec2_sd_configs:
      - region: eu-central-1
        port: 9100

    relabel_configs:
      - source_labels: [__meta_ec2_tag_monitor]
        regex: true
        action: keep
EOF

# Add docker-compose.yml
mkdir -p /opt/monitoring

cat <<EOF > /opt/monitoring/docker-compose.yml
version: "3.8"

services:

  prometheus:
    image: prom/prometheus:latest
    container_name: prometheus
    volumes:
    - /opt/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml
    - /opt/prometheus/rules/alert_rules.yml:/etc/prometheus/rules/alert_rules.yml
    ports:
      - "9090:9090"
    restart: unless-stopped

  grafana:
    image: grafana/grafana:latest
    container_name: grafana
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin
      - GF_SECURITY_ADMIN_USER=admin
    ports:
      - "3000:3000"
    restart: unless-stopped
EOF

# Start services
cd /opt/monitoring
docker-compose up -d
