# Original idea : https://stackoverflow.com/questions/61948833/how-to-copy-a-file-from-local-machine-to-a-storage-account-using-terraform/61950277#61950277
 resource "azurerm_storage_share" "example" {
      name                 = "sharename"
      storage_account_name = azurerm_storage_account.example.name
      quota                = 50

      acl {
        id = "xxxxxxxxxxxxxxx"

        access_policy {
          permissions = "rwdl"
          start       = "2020-05-10T09:38:21.0000000Z"
          expiry      = "2020-07-02T10:38:21.0000000Z"
        }
      }
    }

    resource "null_resource" "uploadfile" {

      provisioner "local-exec" {


      command = <<-EOT
      $storageAcct = Get-AzStorageAccount -ResourceGroupName "${azurerm_resource_group.example.name}" -Name "${azurerm_storage_account.example.name}"
       Set-AzStorageFileContent `
       -Context $storageAcct.Context `
       -ShareName "${azurerm_storage_share.example.name}" `
       -Source "C:\Users\xxx\terraform\test.txt" `
       -Path "test.txt"

      EOT

      interpreter = ["PowerShell", "-Command"]
      }

}