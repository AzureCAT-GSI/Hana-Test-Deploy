#!/bin/bash
#   VMSize="Standard_E16s_v3 (128 GB)" \
#Standard_M128ms (3.8 TB, Certified)
set -x
echo "Reading config...." >&2
if [ "${1}" != "" ]; then
    source ${1}
else
    source ./azuredeploy.cfg
fi

az account set --subscription "$subscriptionid"

#hanavmsize="Standard_E16s_v3 (128 GB)"
#hanavmsize="Standard_M128s (2 TB, Certified)"

echo "creating hana cluster"
az group deployment create \
--name HANADeployment \
--resource-group $rgname \
   --template-uri "https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzureCAT-GSI%2FHana-Test-Deploy%2Fmaster%2Fsap-hana-cluster/azuredeploy-hsr-infra.json" \
   --parameters \
   VMName1=$HANAVMNAME1 \
   VMName2=$HANAVMNAME2 \
   VMSize="Standard_E16s_v3 (128 GB)" \
   NetworkName=$vnetname \
   HANASubnetName=$dbsubnetname \
   VMUserName=$vmusername \
   VMPassword=$vmpassword \
   OperatingSystem="SLES for SAP 12 SP3" \
   ExistingNetworkResourceGroup="$vnetrgname" \
   StaticIP1=$HANAIP1 \
   StaticIP2=$HANAIP2 \
   iSCSIIP=$ISCSIIP \
   SubscriptionEmail="$slesemail" \
   SubscriptionID="$slesreg" \
   SMTUri="$slessmt" \
   ILBIP=$HANAILBIP

echo "hana cluster created"
