$VaultVersion = "2025"                                                            #Version of target Vault
$powerLoadPath = "C:\Program Files\coolOrange\powerload\Vault_" + $VaultVersion   #path to the powerLoad psd1
Import-Module ($powerLoadPath + "\powerload.psd1") 

# define your database connection
Connect-PowerLoadDatabase -Server 'localhost\AUTODESKVAULT' -DatabaseName 'pl-test' -User 'sa' -Password 'AutodeskVault@26200' -ForceDatabaseCreation

# collect all files from Vault base on the SearchName criteria
Get-VaultData -VaultServer 'localhost' -VaultName 'Vault' -Username 'Administrator' -Password '' -SearchName 'SearchName' -DownloadPath 'c:\temp\VaultFiles' -ExactVersionOnly

$dbCheck = Test-PowerLoadDataBase 

$vaultCheck = Test-PowerLoadVaultBehaviors -Server "localhost" -Vault "Vault" -User "Administrator" -Password "" 

Export-BCP -ExportDirectory 'c:\temp\test_export'          #path must exist
