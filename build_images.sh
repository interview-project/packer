#!/bin/bash

# Create temporary cookbooks folder
rm -Rf cookbooks
mkdir cookbooks
cd cookbooks

# Clone cookbooks
git clone git@github.com:interview-project/jenkins.git
git clone git@github.com:interview-project/nexus.git
git clone git@github.com:chef-cookbooks/docker.git

cd ..

# Ensure the environment variables for AWS are provided
: "${AWS_ACCESS_KEY_ID:?Please make sure you have exported an AWS_ACCESS_KEY_ID.}"
: "${AWS_SECRET_ACCESS_KEY:?Please make sure you have exported an AWS_SECRET_ACCESS_KEY.}"

# Build an AMI based on standard Ubuntu image, add Chef install via Packer
packer build -var 'cookbook=jenkins' ubuntu.json
packer build -var 'cookbook=nexus' ubuntu.json
