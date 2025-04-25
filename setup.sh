#!/bin/bash

set -e

# Function to display messages
log() {
  echo -e "\e[1;32m$1\e[0m"
}

log "Updating package list and installing prerequisites..."
sudo apt-get update
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

log "Adding Docker’s official GPG key..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

log "Setting up the Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

log "Updating package list again..."
sudo apt-get update

log "Installing Docker Engine, CLI, and containerd..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

log "Starting and enabling Docker service..."
sudo systemctl start docker
sudo systemctl enable docker

log "Adding current user to the docker group..."
sudo usermod -aG docker $USER

log "Applying new group membership..."
newgrp docker <<EONG

log "Cloning FramePack-Docker-CUDA repository..."
git clone https://github.com/akitaonrails/FramePack-Docker-CUDA.git
cd FramePack-Docker-CUDA

log "Creating necessary directories..."
mkdir -p outputs hf_download

log "Building the Docker image..."
docker build -t framepack-torch26-cu124:latest .

log "Running the Docker container..."
docker run -it --rm --gpus all -p 7860:7860 \
  -v ./outputs:/app/outputs \
  -v ./hf_download:/app/hf_download \
  framepack-torch26-cu124:latest

EONG

log "Setup complete. Access the application at http://localhost:7860"
