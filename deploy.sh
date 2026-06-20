#!/bin/bash
# deploy.sh – Automated Foundation Build for TruckOps
set -euo pipefail

echo "🚀 Starting TruckOps Foundation Deployment..."

# 1. GCP Project setup (assumes gcloud installed and authenticated)
PROJECT_ID="truckops-$(date +%s)"
echo "Creating GCP project: $PROJECT_ID"
gcloud projects create "$PROJECT_ID" --name="TruckOps"
gcloud config set project "$PROJECT_ID"
gcloud services enable compute.googleapis.com

# 2. Create VM instance
ZONE="us-central1-a"
VM_NAME="truckops-vm"
echo "Creating VM: $VM_NAME"
gcloud compute instances create "$VM_NAME" \
    --zone="$ZONE" \
    --machine-type=e2-small \
    --image-family=debian-12 \
    --image-project=debian-cloud \
    --boot-disk-size=20GB

# 3. Install Docker and OpenClaw (via SSH)
echo "Installing Docker and OpenClaw on VM..."
gcloud compute ssh "$VM_NAME" --zone="$ZONE" --command='
    sudo apt update && sudo apt install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
    # Install OpenClaw (latest)
    curl -fsSL https://get.openclaw.ai | sh
    # Add user to docker group
    sudo usermod -aG docker "$USER"
'

# 4. Configure model provider
echo "Configure model provider endpoint (provide API key later)"
# Placeholder: the user must set the OPENCLAW_MODEL_CONFIG env var

# 5. Create workspace and upload bootstrap
echo "Creating TruckOps workspace..."
gcloud compute ssh "$VM_NAME" --zone="$ZONE" --command='
    mkdir -p /opt/truckops
    git clone https://github.com/brooksjoey11/truckops /opt/truckops/workspace
'

# 6. Generate Initialization Report
echo "Generating Initialization Report..."
gcloud compute ssh "$VM_NAME" --zone="$ZONE" --command='
    cd /opt/truckops/workspace
    openclaw init --report
'

VM_IP=$(gcloud compute instances describe "$VM_NAME" --zone="$ZONE" --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
echo "✅ Foundation build complete. VM is ready at IP: $VM_IP"
echo "Next steps: Configure model API key and start the Orchestrator Agent."
