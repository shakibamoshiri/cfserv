#!/bin/bash

set -euTCo pipefail
set -x

###
# https://pkg.cloudflareclient.com/

# Add cloudflare gpg key
curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg |  gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg


# Add this repo to your apt repositories
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" |  tee /etc/apt/sources.list.d/cloudflare-client.list


# Install
apt-get update -y
apt-get install -y cloudflare-warp

### find the cli
which warp-cli

### register
warp-cli regisrer

### tunnel mode
warp-cli set-mode tunnel_only

### exclude all
warp-cli add-excluded-route 0.0.0.0/0

### check the settings
warp-cli settings

### connect
warp-cli connect

### check status
warp-cli status

