#Solution 1
$Credential = Get-Credential
Connect-AzAccount -Credential $Credential -Tenant 'xxxx-xxxx-xxxx-xxxx' -ServicePrincipal

$Context = New-AzStorageContext -StorageAccountName "myaccountname" -UseConnectedAccount

# Solution 2
# $SasToken = New-AzStorageContainerSASToken -Name "Container" -Permission "rad"
# $Context = New-AzStorageContext -StorageAccountName "" -SasToken $SasToken
# $Context | Get-AzStorageBlob -Container "Container"

# Set-AzStorageBlobContent -File "D:\_TestImages\Image000.jpg" `
#   -Container $containerName `
#   -Blob "Image001.jpg" `
#   -Context $Context


# Solution 3 - Powershell from terraform container
#  resource "azurerm_storage_share" "example" {
#       name                 = "sharename"
#       storage_account_name = azurerm_storage_account.example.name
#       quota                = 50

#       acl {
#         id = "xxxxxxxxxxxxxxx"

#         access_policy {
#           permissions = "rwdl"
#           start       = "2020-05-10T09:38:21.0000000Z"
#           expiry      = "2020-07-02T10:38:21.0000000Z"
#         }
#       }
#     }

#     resource "null_resource" "uploadfile" {

#       provisioner "local-exec" {


#       command = <<-EOT
#       $storageAcct = Get-AzStorageAccount -ResourceGroupName "${azurerm_resource_group.example.name}" -Name "${azurerm_storage_account.example.name}"
#        Set-AzStorageFileContent `
#        -Context $storageAcct.Context `
#        -ShareName "${azurerm_storage_share.example.name}" `
#        -Source "C:\Users\xxx\terraform\test.txt" `
#        -Path "test.txt"

#       EOT

#       interpreter = ["PowerShell", "-Command"]
#       }

# }