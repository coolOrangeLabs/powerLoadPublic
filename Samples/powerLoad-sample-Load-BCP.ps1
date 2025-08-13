  	#### Sample for moving the data of a sample Vault into a new target Vault into a new sub-folder   ##########
##   by loading a BCP-package into the powerLoad database (IDB)
##   moving all design files and folders into new sub-folder 'Division_007'
##   and cleaning some files and folders.
##
##  To use this sample you need to create or have a BCP-package that contains a design folder "Designs".
#### No guarantee of correctness and up-to-dateness!    ####################################################


# Load powerLoad modules 
# TODO: Adjust Vault version for target Vault
$VaultVersion = "2025"
$powerLoadPath = "C:\Program Files\coolOrange\powerload\Vault_" + $VaultVersion
Import-Module ($powerLoadPath + "\powerload.psd1") -Verbose

### General settings (must be adjusted to your environment!)
$LogPath = "C:\coolOrange\powerLoad-csv-logs\"               #Folder for CSV-log files
$BCPFolder = "MyBCP-package"                                 #TODO: Rename to the folder name of your BCP-package to import
$ImportPath = "C:\temp\VaultBCP\ExportPackages\$BCPFolder"   #DTU-Export location
$ExportPath = "C:\temp\VaultBCP\pL-Exports\$BCPFolder"       #powerLoad-Export location
## Connection to SQL Instance
$SQLServer = "(local)\AUTODESKVAULT"
$IDB = "pL_BCP_Sample"                            #powerLoad database
$SQLUser = "SA"
$SAPassword = "AutodeskVault@26200"
## Connection to Target Vault
$VaultServer = "localhost"                      #Target server name
$VaultDB = "Vault_Target"                       #Name of your target Vault DB
$VaultUser = "Administrator"
$VaultPW = ""

# Create or connect to your powerLoad db
Connect-powerLoadDatabase -Server $SQLServer -DatabaseName $IDB -User $SQLUser -Password $SAPassword -ForceDatabaseCreation

# Import BCP-package to powerLoad db
$result = Import-BCP -ImportPath $ImportPath
### Review import:
## All files are in table 'Files'. The path to the file resides in field 'LocalFullFileName'
## Review system fields and UDPs

#region for your database modifications ###
# Changing LocalFullFileName from relative to full path that file can be found after powerLoad BCP-Export
Invoke-PowerLoadSql -Statement "UPDATE Files SET LocalFullFileName = (REPLACE (LocalFullFileName, '.\', 'C:\temp\VaultBCP\ExportPackages\$BCPFolder\')) where LocalFullFileName like '.\$BCPFolder-files-0\%'"
# Delete unused files
#Invoke-PowerLoadSql -Statement "DELETE FROM Files where VaultFileName = 'Designs.ipj'"
Invoke-PowerLoadSql -Statement "DELETE FROM Files where FileExtension in ('bak', 'zip')"
# Create new Folder '$/Designs/Division_007' to which all files shall be moved
Invoke-PowerLoadSql -Statement "INSERT INTO [dbo].[Folders] ([FolderID], [VaultFolderName], [VaultPath], [IsLibrary], [Category], [CreateUser], [CreateDate]) VALUES ((SELECT MAX(FolderID)+1 FROM Folders), 'Division_007','$/Designs/Division_007','0','Folder','powerLoad','2024-04-01 00:00')"
# Move all Design folders under folder '$/Designs' to '$/Designs/Division_007'
Invoke-PowerLoadSql -Statement "UPDATE Folders SET VaultPath = REPLACE(VaultPath, '$/Designs/', '$/Designs/Division_007/') FROM Folders where VaultPath like '$/Designs/%' and VaultFolderName <> 'Division_007'"
# Correct ParentFolderID (folder structure is defined by 'VaultPath'), as Folders are move to '$/Designs/Division_007/'
Invoke-PowerLoadSql -Statement "UPDATE Folders SET ParentFolderID = NULL where ParentFolderID = (SELECT FolderID FROM Folders where VaultFolderName = 'Designs')"
# Move all Design files from folder '$/Designs' to '$/Designs/Division_007'(, if there are files in folder '$/Designs')
Invoke-PowerLoadSql -Statement "UPDATE Files SET FolderID = (SELECT FolderID FROM Folders where VaultPath = '$/Designs/Division_007') where FolderID = (SELECT FolderID FROM Folders where VaultPath = '$/Designs')"# Set ('PDF', 'BMP', 'JPG') to 'Design Representation' and set behaviours, if your package contains 'PDF', 'BMP', 'JPG'
# Set ('PDF', 'BMP', 'JPG') to 'Design Representation' and set behaviours, if your package contains 'PDF', 'BMP', 'JPG'
Invoke-PowerLoadSql -Statement "UPDATE Files SET Category = 'Design Representation' where FileExtension in ('PDF', 'BMP', 'JPG') and Category = 'Base'"
Invoke-PowerLoadSql -Statement "UPDATE Files SET LifecycleState = 'Released' where Category = 'Design Representation'"
Invoke-PowerLoadSql -Statement "UPDATE Files SET LifecycleDefinition = 'Design Representation Process' where Category = 'Design Representation'"
#endregion SQL modifications ###

### Validation for IDB integrity
Test-PowerLoadDataBase -ErrorCSVPath ($LogPath + "IDB_errors.csv")
## Check files in SQL
## DWF(x) and IPJ file an be ignored, as these do not need a Content Source


### Validate IDB against Vault
Test-PowerLoadVaultBehaviors -Server $VaultServer -Vault $VaultDB -User $VaultUser -Password $VaultPW -ErrorCSVPath ($LogPath + 'VLTBehaviors_errors.csv')

# Export IDB to BCP-package
$result = Export-BCP -ExportDirectory $ExportPath -DisableConfig 1 

## Import BCP-package to target Vault with DTU


### General hints
# Showing parameter for cmdlet
Get-Help Export-BCP

