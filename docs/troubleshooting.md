# Troubleshooting

## Package installation cannot reach repositories
- Confirm the VM is attached to the expected subnet.
- Confirm NAT Gateway is associated with that subnet and has a Standard public IP.
- Review effective routes and outbound NSG rules.
- Retry installation with VM Run Command after outbound access is restored.
- NAT Gateway provides outbound connectivity; it does not create inbound access to the VM.

## TCP/80 test fails
- Check `sudo systemctl is-active nginx` on the destination.
- Check `sudo ss -lntp | grep ':80'`.
- Confirm destination private IP and subnet.
- Review the NSG and guest OS firewall.
- Confirm both VMs are in the intended VNet.

## Connection Monitor has no data
- Confirm monitor and test configuration are enabled.
- Check source endpoint and agent/extension health.
- Verify destination address and port.
- Confirm workspace integration/export is configured.
- Expand the Log Analytics time range and allow for ingestion delay.
- Run discovery KQL before assuming table names.

## VM size or quota error
- Choose a size available in the selected region.
- Check vCPU quota and request an increase if needed.
- Set `VM_SIZE` before deployment.

