#!/usr/bin/env bash
set -euo pipefail
: "${RESOURCE_GROUP:?Source scripts/00-set-variables.sh first}"
echo "WARNING: all resources in $RESOURCE_GROUP will be deleted."
read -r -p "Type the exact resource group name to continue: " CONFIRM
[[ "$CONFIRM" == "$RESOURCE_GROUP" ]] || { echo "Name mismatch; cancelled."; exit 1; }
az group delete --name "$RESOURCE_GROUP" --yes --no-wait
echo "Deletion initiated. Verify with: az group exists --name $RESOURCE_GROUP"
