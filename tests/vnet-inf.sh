echo "Reading config...." >&2
source ./azuredeploy.cfg

az account set --subscription $subscriptionid

echo "creating resource group"
az group create --name $rgname --location "West US 2"

echo "creating vnet"
az group deployment create \
--name vnetDeployment \
--resource-group $rgname \
--template-uri "https://raw.githubusercontent.com/AzureCAT-GSI/Hana-Test-Deploy/master/vnet.json" \
--parameters \
             addressPrefix="10.0.0.0/16" \
             DBsubnetName=$dbsubnetname \
             DBsubnetPrefix="10.0.0.0/24" \
             AppsubnetName=$appsubnetname \
             AppsubnetPrefix="10.0.1.0/24" \
             mgtsubnetName=$mgtsubnetname \
             mgtsubnetPrefix="10.0.2.0/24" \
             vnetName=$vnetname
