#!/usr/bin/env bash
set -euo pipefail
: "${RESOURCE_GROUP:?Source scripts/00-set-variables.sh first}"
read -r -p "Remove NAT Gateway from $RESOURCE_GROUP? Type REMOVE-NAT: " CONFIRM
[[ "$CONFIRM" == "REMOVE-NAT" ]] || { echo "Cancelled"; exit 0; }
az network vnet subnet update -g "$RESOURCE_GROUP" --vnet-name "$VNET_NAME" -n "$SUBNET_NAME" --remove natGateway -o none
az network nat gateway delete -g "$RESOURCE_GROUP" -n "$NAT_GW_NAME"
az network public-ip delete -g "$RESOURCE_GROUP" -n "$NAT_PIP_NAME"
echo "NAT Gateway and public IP removed."
