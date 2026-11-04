#!/usr/bin/env bash
set -euo pipefail
: "${RESOURCE_GROUP:?Source scripts/00-set-variables.sh first}"
az account show >/dev/null
az group create -n "$RESOURCE_GROUP" -l "$LOCATION" -o none
az network vnet create -g "$RESOURCE_GROUP" -n "$VNET_NAME" -l "$LOCATION" --address-prefixes "$VNET_PREFIX" --subnet-name "$SUBNET_NAME" --subnet-prefixes "$SUBNET_PREFIX" -o none
az network nsg create -g "$RESOURCE_GROUP" -n "$NSG_NAME" -l "$LOCATION" -o none
az network nsg rule create -g "$RESOURCE_GROUP" --nsg-name "$NSG_NAME" -n Allow-VNet-TCP-80 --priority 200 --direction Inbound --access Allow --protocol Tcp --source-address-prefixes "$VNET_PREFIX" --source-port-ranges '*' --destination-address-prefixes '*' --destination-port-ranges 80 -o none
az network vnet subnet update -g "$RESOURCE_GROUP" --vnet-name "$VNET_NAME" -n "$SUBNET_NAME" --network-security-group "$NSG_NAME" -o none
az network public-ip create -g "$RESOURCE_GROUP" -n "$NAT_PIP_NAME" -l "$LOCATION" --sku Standard --allocation-method Static -o none
az network nat gateway create -g "$RESOURCE_GROUP" -n "$NAT_GW_NAME" -l "$LOCATION" --public-ip-addresses "$NAT_PIP_NAME" --idle-timeout 10 -o none
az network vnet subnet update -g "$RESOURCE_GROUP" --vnet-name "$VNET_NAME" -n "$SUBNET_NAME" --nat-gateway "$NAT_GW_NAME" -o none
az monitor log-analytics workspace create -g "$RESOURCE_GROUP" -n "$LAW_NAME" -l "$LOCATION" -o none
for VM in "$SRC_VM_NAME" "$DEST_VM_NAME"; do
  az vm create -g "$RESOURCE_GROUP" -n "$VM" -l "$LOCATION" --image Ubuntu2204 --size "$VM_SIZE" --admin-username "$ADMIN_USERNAME" --generate-ssh-keys --vnet-name "$VNET_NAME" --subnet "$SUBNET_NAME" --public-ip-address "" -o none
done
echo "Infrastructure created. Review VM, NSG, NAT, and workspace configuration in Azure."
