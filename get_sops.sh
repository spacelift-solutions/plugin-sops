#!/usr/bin/env bash

mkdir -p /mnt/workspace/plugin_sops/sops_binary/
cd /mnt/workspace/plugin_sops/sops_binary/
if [[ "$(arch)" == "x86_64" ]];then
  curl https://github.com/getsops/sops/releases/download/v3.9.1/sops-v3.9.1.linux.amd64 -o sops -L
else
  curl https://github.com/getsops/sops/releases/download/v3.9.1/sops-v3.9.1.linux.arm64 -o sops -L
fi
chmod +x sops
