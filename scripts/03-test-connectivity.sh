#!/usr/bin/env bash
set -euo pipefail
: "${RESOURCE_GROUP:?Source scripts/00-set-variables.sh first}"
DEST_IP="$(az vm list-ip-addresses -g "$RESOURCE_GROUP" -n "$DEST_VM_NAME" --query '[0].virtualMachine.network.privateIpAddresses[0]' -o tsv)"
test -n "$DEST_IP" && test "$DEST_IP" != "None"
echo "Testing destination private IP: $DEST_IP"
az vm run-command invoke -g "$RESOURCE_GROUP" -n "$SRC_VM_NAME" --command-id RunShellScript --scripts "python3 -c 'import socket; s=socket.create_connection((\\\"$DEST_IP\\\",80),timeout=5); print(\\\"TCP/80 connected\\\"); s.close()' && curl -I --max-time 8 http://$DEST_IP/"
