# Davesdere 2021 - Ca va bien aller
# To get the key, and then create the SAS, an Azure AD security principal must be assigned an Azure role 
# that includes the Microsoft.Storage/storageAccounts/blobServices/generateUserDelegationKey action.
# 
# az storage account keys list -g MyResourceGroup -n MyStorageAccount
import os, sys, logging
from datetime import datetime, timedelta
from azure.storage.fileshare import ShareServiceClient, generate_account_sas, ResourceTypes, AccountSasPermissions
from azure.storage.fileshare import ShareClient
from azure.storage.fileshare import ShareFileClient
from azure.storage.fileshare import ShareDirectoryClient

def refresh_var_env(print_this=False):
    ACCOUNT_NAME = os.environ.get("AZURE_STORAGE_ACCOUNT_NAME")
    AZURE_STORAGE_ACCESS_KEY = os.environ.get("AZURE_STORAGE_ACCESS_KEY")
    ID_KEY = os.environ.get("ID_KEY") # Account-Access-Key
    AZURE_STORAGE_ACCOUNT_URL =  os.environ.get("AZURE_STORAGE_ACCOUNT_URL")
    AZ_CONN_STR = "AZ_CONN_STR"
    AZ_SAS_TOKEN = "AZ_SAS_TOKEN"
    if print_this == True: print(f"AZ_ACCOUNT_NAME: {ACCOUNT_NAME} \AZURE_STORAGE_ACCESS_KEY: {AZURE_STORAGE_ACCESS_KEY}")

refresh_var_env()

def create_file_share(this_share_name):
    """
    Input: 
        - func input: type(this_share_name) == type(str())
        - env:ACCOUNT_NAME
        - env:ID_KEY
    Returns: Connection_object ShareClient()
    """
    refresh_var_env()
    connection_string = f"DefaultEndpointsProtocol=https;AccountName={ACCOUNT_NAME};AccountKey={ID_KEY};EndpointSuffix=core.windows.net"
    os.putenv(AZ_CONN_STR, connection_string)
    
    share = ShareClient.from_connection_string(
        conn_str=connection_string, 
        share_name=this_share_name
        )
    returns = share.create_share()
    return returns

def get_a_sas_token(put_env=False):
    """
    Input: 
        - env:ACCOUNT_NAME
        - env:AZURE_STORAGE_ACCESS_KEY
    Returns: Connection_object ShareServiceClient()
    """
    refresh_var_env()
    sas_token = generate_account_sas(
        account_name=ACCOUNT_NAME,
        account_key=AZURE_STORAGE_ACCESS_KEY,
        resource_types=ResourceTypes(service=True),
        permission=AccountSasPermissions(read=True),
        expiry=datetime.utcnow() + timedelta(hours=1)
    )
    if put_env != False:os.putenv(AZ_SAS_TOKEN, connection_string)
    
    share_service_client = ShareServiceClient(
        account_url=f"https://{ACCOUNT_NAME}.file.core.windows.net", 
        credential=sas_token
    )
    return share_service_client

def download_a_file(this_file_path, this_share_name, local_file_path):
    refresh_var_env()
    file_client = ShareFileClient.from_connection_string(
        conn_str=AZ_CONN_STR, 
        share_name=this_share_name, 
        file_path=this_file_path
        )

    with open(local_file_path, "wb") as file_handle:
        data = file_client.download_file()
        data.readinto(file_handle)
        return 0
    
def ls_dir_files(this_share_name, this_dir_path):
        """
    Input: 
        - func input: type(this_share_name) == type(str())
        - func input: type(this_dir_path) == type(str())
        - env:AZ_CONN_STR
    Returns: list()
    """
    parent_dir = ShareDirectoryClient.from_connection_string(
        conn_str=AZ_CONN_STR, 
        share_name=this_share_name, 
        directory_path=this_dir_path
        )
    this_list = list(parent_dir.list_directories_and_files())
    print(this_list)
    return this_list


def set_logging_to_debug():
    """
    Prints in stdout

    Input:
        - env:AZ_CONN_STR
    Returns: Connection_object ShareServiceClient()
    """
    # Create a logger for the 'azure.storage.fileshare' SDK
    logger = logging.getLogger('azure.storage.fileshare')
    logger.setLevel(logging.DEBUG)

    # Configure a console output
    handler = logging.StreamHandler(stream=sys.stdout)
    logger.addHandler(handler)

    # This client will log detailed information about its HTTP sessions, at DEBUG level
    service_client = ShareServiceClient.from_connection_string(AZ_CONN_STR, logging_enable=True)
    return service_client