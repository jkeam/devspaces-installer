#!/bin/bash

PASSWORD=some_password_here
URL=https://api.whatever:6443
USERNAME=admin

echo "Logging in..."
oc login --username=${USERNAME} \
  --insecure-skip-tls-verify=true \
  --server=${URL} \
  --password=${PASSWORD}

echo "Installing..."
./install.sh
