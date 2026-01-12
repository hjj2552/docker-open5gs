#!/bin/bash

# 에러 발생 시 즉시 중단
set -e

echo "[*] Checking .env file..."
if [ -f .env ]; then
    # .env 변수들을 자동으로 export
    set -a
    source .env
    set +a
    echo " -> .env file loaded."
else
    echo "Error: .env file not found!"
    exit 1
fi

echo "[*] Setting CPU frequency to 'performance'..."
# eNB는 타이밍에 민감하므로 CPU 성능 모드 설정이 필수적입니다.
sudo cpupower frequency-set -g performance

echo "[*] Starting eNB container (Detached)..."
docker compose -f srsenb.yaml up -d

echo "[*] Attaching to srsenb console..."
# 컨테이너 실행 후 바로 콘솔에 붙습니다.
docker container attach srsenb

