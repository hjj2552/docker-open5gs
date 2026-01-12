#!/bin/bash

# 스크립트 실행 중 에러 발생 시 즉시 중단
set -e

echo "[*] Checking .env file..."
if [ -f .env ]; then
    # .env의 변수들을 자동으로 export 하여 하위 프로세스(docker compose)에 전달
    set -a
    source .env
    set +a
    echo " -> .env file loaded."
else
    echo "Error: .env file not found!"
    exit 1
fi

echo "[*] Disabling UFW (Firewall)..."
sudo ufw disable

echo "[*] Enabling IP Forwarding..."
sudo sysctl -w net.ipv4.ip_forward=1

echo "[*] Starting 4G Core + VoLTE Network..."
docker compose -f 4g-volte-deploy.yaml up

