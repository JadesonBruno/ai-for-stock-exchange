#!/usr/bin/env bash
set -euo pipefail

# Default APP_DIR if not provided
APP_DIR="${APP_DIR:-/opt/ai-for-stock-exchange}"

# Install prerequisites
sudo apt-get update -y
sudo apt-get install -y --no-install-recommends \
    ca-certificates \
    curl

# Add Docker’s official GPG key and set up the stable repository
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources > /dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

# Install Docker and Docker Compose
sudo apt-get update -y
sudo apt-get install -y --no-install-recommends \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

# Start and enable Docker service
sudo systemctl enable --now docker

# Navigate to application directory and start the app
cd "$APP_DIR"
sudo docker compose up -d --build
