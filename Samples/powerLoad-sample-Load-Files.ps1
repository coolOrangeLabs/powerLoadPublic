#### Sample for loading files from a filestore with powerLoad  ####
#### No guarantee of correctness and up-to-dateness!           ####
<#  Agenda
1. Load powerShell cmdlets for powerLoad
2. Initialization
3. Connection to powerLoad db
4. Import files from root-folder(s) into the powerLoad intermediate database (IDB)
5. Analyse Inventor references and analysis with alternativePaths
6. AutoCAD references analysis
7. Modify data in SQL database for target Vault
8. Transfer iProperties
9. Validate data
10. Create BCP-package
#>


#region 1: Load powerLoad modules 
# TODO: Adjust folder to where the ZIP is extracted
$powerLoadPath = "c:\coolOrange\powerLoad\powerLoad.psd1"
Get-ChildItem -Path $powerLoadPath -Filter powerload.psd1 | Unblock-File   # Unblocks psd1 if windows blocked the downloaded ZIP
Get-ChildItem -Path $powerLoadPath -Filter *.dll -Recurse | Unblock-File   # Unblocks DLLs if windows blocked the downloaded ZIP
Import-Module $powerLoadPath -Verbose
#endregion

#region 2: Initialization
### General settings
$AutomaticBCPExport = $false		                                  # set to "$true" when script shall not stop before BCP-Export
$LogPath = "C:\coolOrange\powerLoad-csv-logs\"		                  # Folder for Error-CSV files
$importPath = ("C:\Data\LegacyFilestore", "C:\Data\OutOfProject")     # Define your import path(s). Only files that are imported, can be handled for the CAD reference analysis!
$exportPath = "C:\temp\VaultBCP\pL-Exports\pL_Files_Sample"           # Define your powerLoad-Export location
## SQL settings for IDB
$SQLServer = "(local)\AUTODESKVAULT"
$IDB = "pl_Files_Sample"                                              #powerLoad database
$SQLUser = "SA"
$SAPassword = "AutodeskVault@26200"
## Target Vault settings
$VaultServer = "localhost"
$VaultDB = "Vault_Target"                                       #Target server name
$VaultUser = "Administrator"                                    #Name of your target Vault DB
$VaultPW = ""
#endregion Initialization

#region 3: Create or connect to powerLoad db
Connect-powerLoadDatabase -Server $SQLServer -DatabaseName $IDB -User $SQLUser -Password $SAPassword -ForceDatabaseCreation
# ConnectString for Trusted_Connection
# Connect-powerLoadDatabase -ConnectString "Server=$SQLServer;Database=$IDB;Trusted_Connection=True;" -ForceDatabaseCreation  
#endregion

#region 4: File Import to IDB
### Exclude folders and specify wanted file extensions for import
$ExcludeFolders = @("OLDVERSIONS", "OBSOLETE", "Presets")       ### Caution! This also exclude filenames with these strings
$ExcludeFoldersFull = $ExcludeFolders -join '|'
$IncludeFileExtensions = @("*.ipt", "*.iam", "*.idw", "*.ipn", "*.dwg", "*.dwf", "*.xls", "*.xlsx", "*.doc", "*.docx", "*.fres", "*.fsat", "*.fwiz", "*.bmp", "*.png", "*.htm")
# Mapping for imported folders to Vault folders:
$rootDirectories = @{"C:\Data\LegacyFilestore\Designs" = "$/Designs"; 
"C:\Data\LegacyFilestore\Content Center Files" = "$/Content Center Files"; 
"C:\Data\LegacyFilestore\Library" = "$/Libraries";
"C:\Data\OutOfProject" = "$/Designs/OutOfProject"
}   
#Collect all files from the import path:
$result = Get-ChildItem -Path $ImportPath -File -Recurse -Include $IncludeFileExtensions | Where-Object {$_.FullName -notmatch $ExcludeFoldersFull} | Import-FilesToDatabase -FileObject -rootDirectories $rootDirectories -ErrorCSVPath ($LogPath + "ImportInIDB_errors.csv") #-Verbose
#endregion File Import to IDB

#region 5.1: Analse Inventor references
$IPJFile = "C:\Data\LegacyFilestore\Designs.ipj"                    #TODO: Define Inventor project file for analysis!
$Starttime=Get-Date                                                 #Start of analysis
$refCheck = Resolve-InventorReferences -InventorProjectFile $IPJFile -ErrorCSVPath ($LogPath + "InvAnalysis_errors.csv") 
$EndTime = Get-Date
$duration = $EndTime - $Starttime
Write-Host "Inventor analysis time [h]: $($duration.TotalHours)"    #Time for 1st Inventor analysis
if($refCheck.Errors -gt 0) { Write-Host "Reference errors found. Check InvAnalysis_errors.csv" }
#endregion

#region 5.2:  2nd Inventor Analysis with alternativePaths
<# In case you have references errors, the alternative path may help you resolve them. 
Syntax: 'Old path where reference was found, when file was saved last time' = 'New path from where file is imported' #>
$alternativePaths = @{'c:\legacy filestore\designs\engine mkii\components'='C:\Data\OutOfProject'}  
$Starttime=Get-Date
$refCheck = Resolve-InventorReferences -InventorProjectFile $IPJFile -ErrorCSVPath ($LogPath + "InvAnalysis_errors.csv") -AlternativePaths $alternativePaths
$EndTime = Get-Date
$duration = $EndTime - $Starttime
Write-Host "Inventor analysis time [h]: $($duration.TotalMinutes)"    #Time for 2nd Inventor analysis with alternativePaths; As only files are analyzed that had errors in the 1st run, it is often much faster.
# Files that cannot be found in IDB cannot be resolved!
#endregion Inventor analysis with alternativePaths

#region 6: Analse AutoCAD references
$Starttime=Get-Date
Resolve-AutoCADReferences -ErrorCSVPath ($LogPath + "ACAD-Ref_errors.csv") 
$EndTime = Get-Date
$duration = $EndTime - $Starttime
Write-Host "AutoCAD analysis time [min]: $($duration.TotalMinutes)"    #Time for AutoCAD analysis; there are no alternativePaths available!
#endregion AutoCAD analysis

##### Modifing data in powerLoad db #####
#region 7: Clean up and adjustment to target Vault
# Set Content Center (sub-)folders to IsLibrary='1'
Invoke-PowerLoadSql -Statement "UPDATE Folders SET IsLibrary = '1' where VaultPath like '$/Content Center Files%'"
# Correcting Category, State and LC Definition for Content Center parts
Invoke-PowerLoadSql -Statement "UPDATE Files SET Category = 'Standard' where FolderID in (SELECT FolderID FROM Folders where VaultPath like '$/Content Center Files%')"
Invoke-PowerLoadSql -Statement "UPDATE Files SET LifecycleDefinition = 'Simple Release Process' where Category = 'Standard'"
Invoke-PowerLoadSql -Statement "UPDATE Files SET LifecycleState = 'Released' where Category = 'Standard'"
# DELETE Folder TEST and all its files and their FileFileRelations
Invoke-PowerLoadSql -Statement "DELETE FROM FileFileRelations where ParentFileID in (SELECT FileID FROM Files where FolderID in (SELECT FolderID FROM Folders where VaultPath like '$/Designs/TEST%'))"
Invoke-PowerLoadSql -Statement "DELETE FROM Files where FolderID in (SELECT FolderID FROM Folders where VaultPath like '$/Designs/TEST%')"
Invoke-PowerLoadSql -Statement "DELETE FROM Folders where VaultPath like '$/Designs/TEST%'"
# Set Category = 'Base' for Non-Engineering files
Invoke-PowerLoadSql -Statement "UPDATE Files SET Category = 'Base' where Category = 'Engineering' and FileExtension not in ('iam', 'ipt', 'idw', 'ipn','dwg')"
# Correcting LC and Revision Definition for Category 'Base'
Invoke-PowerLoadSql -Statement "UPDATE Files SET RevisionDefinition = Null where Category = 'Base' and RevisionDefinition is not Null"
Invoke-PowerLoadSql -Statement "UPDATE Files SET RevisionLabel = Null where Category = 'Base' and RevisionDefinition is Null"
Invoke-PowerLoadSql -Statement "UPDATE Files SET LifecycleState = Null where Category = 'Base' and LifecycleState is not Null"
Invoke-PowerLoadSql -Statement "UPDATE Files SET LifecycleDefinition = Null where Category = 'Base' and LifecycleDefinition is not Null"
Invoke-PowerLoadSql -Statement "UPDATE Files SET ContentSource = 'IFilter' where FileExtension in ('txt', 'pdf', 'png', 'jpg', 'vb')"
#endregion clean up

#region 8: Import iProperties from Inventor files
# Adding missing fields in IDB
Add-PowerLoadUDP -Entity Files -Name 'Title' -Type Text
Add-PowerLoadUDP -Entity Files -Name 'Project Number' -Type Text
Add-PowerLoadUDP -Entity Files -Name 'Length' -Type Text
# Marking Inventor files to be read out (SET ImportProperties = 1)
Invoke-PowerLoadSql -Statement "UPDATE Files SET ImportProperties = 1 where FileExtension in ('ipt', 'iam', 'idw') or FileExtension = 'dwg' and ContentSource = 'Inventor'"
# Caution: Transferring the users from the iProperty means that the transferred user must exist in Vault that the file can be imported!
$prop = @{'Author'='CreateUser'; 'Revision Number'='RevisionLabel'; 'Title'='UDP_Title'; 'Project'='UDP_Project Number'; 'Custom:Length'='UDP_Length'}
$Starttime=Get-Date
Import-InventorProperties -Properties $prop
$EndTime = Get-Date
$duration = $EndTime - $Starttime
Write-Host "Time for Inventor porperty extraction [h]: $($duration.TotalMinutes)" 
Invoke-PowerLoadSql -Statement "UPDATE Files SET CreateUser = 'powerLoad' where CreateUser =''"   # Set CreateUser to user 'powerLoad' where 'Author' was empty.
#endregion Import-InventorProperties

#region 9: Validation IDB integrity
Test-PowerLoadDataBase -ErrorCSVPath ($LogPath + "IDB_errors.csv")
### Validate IDB against target Vault
$IDBValidation = Test-PowerLoadVaultBehaviors -Server $VaultServer -Vault $VaultDB -User $VaultUser -Password $VaultPW -ErrorCSVPath ($LogPath + 'VLTBehaviors_errors.csv')
if ($IDBValidation.Errors -ne 0) {
   Write-Host "ERRORs found! Quit script!"
   return
   }
$IDBValidation

## As most likly the users('Author') from iProperty files do not exist in your target Vault, set all files to a default user that is existing in Vault!
Invoke-PowerLoadSql -Statement "UPDATE Files SET CreateUser = 'powerLoad' where CreateUser <> 'powerLoad'"
# Empty UDPs that do not exist in Vault (or create them in Vault)
Invoke-PowerLoadSql -Statement "UPDATE Files SET [UDP_Project Number] = NULL"
Invoke-PowerLoadSql -Statement "UPDATE Files SET [UDP_Length] = NULL"

#Run Test-PowerLoadVaultBehaviors again, to see correction
$IDBValidation = Test-PowerLoadVaultBehaviors -Server $VaultServer -Vault $VaultDB -User $VaultUser -Password $VaultPW -ErrorCSVPath ($LogPath + 'VLTBehaviors_errors.csv')
$IDBValidation
# As [UDP_Project Number] and [UDP_Length] set to NULL, they won't be exported and you can ignore the Error.
#endregion Validation

#region 10: Export BCP-package
if (-not $AutomaticBCPExport) { 
    return
}
Export-BCP -ExportDirectory $exportPath -DisableConfig 1
#endregion Export-BCP

# Now you can run the bat-file to perform DTU-Import

### General hints
<# PowerShell hint:
In PowerShell, there is a difference between single (') and double (") quotes, but this difference only has an effect when you use variables within a string.
    Single apostrophe (') creates a literal string, i.e. the text is used exactly as it was entered, without interpolating variables or interpreting escape sequences.
    Double apostrophe (") allows the interpolation of variables and escape sequences within the string.#>

# Showing parameter for cmdlet
Get-Help Resolve-InventorReferences
Get-Help Import-InventorProperties -Examples
# Don't forget 
