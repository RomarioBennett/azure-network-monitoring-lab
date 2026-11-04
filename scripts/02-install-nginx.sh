#!/usr/bin/env bash
set -euo pipefail
: "${RESOURCE_GROUP:?Source scripts/00-set-variables.sh first}"
az vm run-command invoke -g "$RESOURCE_GROUP" -n "$DEST_VM_NAME" --command-id RunShellScript --scripts "sudo apt-get update && sudo apt-get install -y nginx && sudo systemctl enable --now nginx && sudo systemctl is-active nginx"
