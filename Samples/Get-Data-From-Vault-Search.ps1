$powerLoadPath = "c:\temp\powerLoad\powerload.dll"
Get-ChildItem -Path $powerLoadPath -Filter *.dll -Recurse | Unblock-File
Import-Module $powerLoadPath

# define your database connection
Connect-PowerLoadDatabase -Server 'localhost\powerload' -User 'sa' -Password '' -DatabaseName 'test' -ForceDatabaseCreation

# collect all files from Vault base on the SearchName criteria
Get-VaultData -VaultServer 'localhost' -VaultName 'Vault' -Username 'Administrator' -Password '' -SearchName 'SearchName' -DownloadPath 'c:\temp\VaultFiles' -ExactVersionOnly

Export-BCP -ExportDirectory 'c:\temp\VaultSearchBcp'
