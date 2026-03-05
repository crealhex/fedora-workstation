#!/bin/bash
set -euo pipefail

GITHUB_USER="${1:-crealhex}"
IS_DEFAULT=$([[ "$GITHUB_USER" == "crealhex" ]] && echo true || echo false)

sudo dnf install -y git ansible curl

REPO_DIR=$(mktemp -d)
git clone https://github.com/crealhex/fedora-workstation.git "$REPO_DIR"
cd "$REPO_DIR"

GITHUB_KEYS=$(curl -fL "https://github.com/${GITHUB_USER}.keys")
NET_CONNECTION=$(nmcli -t -f NAME,TYPE con show --active | grep -E 'wireless|ethernet' | head -1 | cut -d: -f1)

ansible-playbook \
  -i "localhost," \
  -c local \
  -e "github_keys='${GITHUB_KEYS}'" \
  -e "static_ip=${IS_DEFAULT}" \
  -e "net_connection='${NET_CONNECTION}'" \
  ansible/playbook.yml

rm -rf "$REPO_DIR"
echo "Done. Reboot recommended."
