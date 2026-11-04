# Deployment notes

- Confirm the active subscription with `az account show`.
- Check regional VM availability and vCPU quota before deployment.
- Review compute, disk, NAT Gateway, public IP, Connection Monitor, and Log Analytics pricing.
- Set `RESOURCE_GROUP` before sourcing `scripts/00-set-variables.sh`.
- Cloud Shell shell variables are temporary. Azure resources persist in the subscription. After reconnecting, set the original resource group name and source the variables file again.
- Private VM addressing does not automatically provide outbound internet. This lab uses NAT Gateway, which is billable.
- Before removing NAT Gateway, verify monitoring agents and Connection Monitor continue to report.
- Run discovery KQL before building analysis queries, workbooks, or alerts. Use the schema returned by your workspace.
