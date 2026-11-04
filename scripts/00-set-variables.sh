#!/usr/bin/env bash
set -euo pipefail
LOCATION="${LOCATION:-eastus}"
RESOURCE_GROUP="${RESOURCE_GROUP:-rg-network-monitoring-demo}"
VNET_NAME="${VNET_NAME:-vnet-network-monitoring}"
SUBNET_NAME="${SUBNET_NAME:-snet-monitoring}"
NSG_NAME="${NSG_NAME:-nsg-network-monitoring}"
NAT_GW_NAME="${NAT_GW_NAME:-nat-network-monitoring}"
NAT_PIP_NAME="${NAT_PIP_NAME:-pip-network-monitoring-nat}"
LAW_NAME="${LAW_NAME:-law-network-monitoring}"
SRC_VM_NAME="${SRC_VM_NAME:-vm-monitor-source}"
DEST_VM_NAME="${DEST_VM_NAME:-vm-monitor-destination}"
VM_SIZE="${VM_SIZE:-Standard_B2s}"
ADMIN_USERNAME="${ADMIN_USERNAME:-azureuser}"
VNET_PREFIX="${VNET_PREFIX:-10.0.0.0/16}"
SUBNET_PREFIX="${SUBNET_PREFIX:-10.0.1.0/24}"
export LOCATION RESOURCE_GROUP VNET_NAME SUBNET_NAME NSG_NAME NAT_GW_NAME NAT_PIP_NAME LAW_NAME SRC_VM_NAME DEST_VM_NAME VM_SIZE ADMIN_USERNAME VNET_PREFIX SUBNET_PREFIX
echo "Loaded variables for $RESOURCE_GROUP in $LOCATION"
