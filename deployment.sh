RESOURCE_GROUP="basic_webapp"
LOCATION="westeurope"


## webapp
WEBAPP_PLAN="webapp-azure-${RANDOM}"
WEBAPP="webapp-azure-${RANDOM}"

#BUILD
# Configure defaults values
az configure --scope local --defaults group=$RESOURCE_GROUP location=$LOCATION 

# create resource group
az group create --resource-group $RESOURCE_GROUP -l $LOCATION
echo "Resource group created"

# create static webapp
az appservice plan create --name $WEBAPP_PLAN --sku B1 --is-linux
az webapp create --name $WEBAPP  --plan $WEBAPP_PLAN --runtime 'python|3.7'
az webapp cors add  -n $WEBAPP --allowed-origins '*'
az webapp config set -n $WEBAPP --startup-file './startup.sh'
az webapp config appsettings set -n $WEBAPP --settings "SCM_DO_BUILD_DURING_DEPLOYMENT=1"

az webapp up -n $WEBAPP