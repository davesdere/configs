export AZ_RESOURCE_GROUP=storagetest
export AZ_STORAGE_ACCOUNT_NAME=datamonger2
export AZ_STORAGE_CONTAINER_1=input
export AZ_DEFAULT_LOCATION=canadacentral
export AZ_SUBS_ID=`az account list | jq -r ".[].id"`

HERE=`pwd`
file_name=helloworld
echo $file_name > $file_name

echo Downloading blob
az storage blob download \
    --account-name ${AZ_STORAGE_ACCOUNT_NAME} \
    --container-name ${AZ_STORAGE_CONTAINER_1} \
    --name $file_name \
    --file downloaded \
    --auth-mode login
