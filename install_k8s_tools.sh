#!/bin/bash

# Install kubectl
echo "Installing kubectl..."
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.31.0/2024-09-12/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv kubectl /usr/local/bin/kubectl
kubectl version --client

# Install eksctl
echo "Installing eksctl..."

# Detect system architecture for eksctl
ARCH=amd64
PLATFORM="$(uname -s)_$ARCH"

curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"

# Optional: Verify checksum
echo "Verifying eksctl checksum..."
curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check || { echo "Checksum verification failed"; exit 1; }

# Extract and move eksctl binary
tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
sudo mv /tmp/eksctl /usr/local/bin
eksctl version

# Run AWS configure
echo "Running AWS configure..."
aws configure
