# POWERLOAD 

This PowerShell extension for powerLoad, is designed to streamline and automate various tasks related to data loading into Vault using the Autodesk DTU (aka. BCP). The load scenarios can be a data loading
- ... from file system, 
- ... from a competitive or legacy system, 
- ... or from Vault to Vault (merge, clean-up or move).

In all 3 cases, you must 
1. prepare your data so that it matches your target Vault,
2. validate if your data fits with your target Vault,
3. and create a valid DTU package which can be loaded into your Vault.

powerLoad helps you do just that. Your data is imported into a temporary powerLoad database where you can perform all necessary data manipulations at high speed, e.g. adding, removing or renaming properties, cleaning values, moving/renaming files and folders, checking and resolving file references and much more. Then powerLoad checks if your data matches the target vault to prevent the load from failing and finally creates a BCP package.

## Supported Vault versions

Vault Professional 2025, 2024, 2023

## Known limitations and issues

Status at 10.07.2025

- Import-BCP ignores secodary associated files
- Import-BCP does not import Folder-Item Links
- Import-BCP does not yet support delta
- Export-BCP does not yet support delta
- Item BOMs are not supported
- File BOM blobsare not supported. However, in case of a Vault to Vault migration, the IDs remain the same, so the existing BOM blobs can be reused, if meta-data are not changed.
- Export-BCP and Import-BCP may run into SQL command timeout when used for very huge data.
If that happens, the user can increase the setting 'CommandTimeout' in the config file 'DatabaseManager.dll.config' in the install location. By default it is set to 900 seconds


## Prerequisites

Operating System: Windows 10 and 11

Installed Programs: Autodesk Vault, coolOrange powerLoad/bcpToolkit V25 ([download](https://www.coolorange.com/powerload-download-page)), Microsoft PowerShell, AutoCAD Mechanical if AutoCAD DWGs and/or Inventor if Inventor files to be analyzed for missing references

Database: MS SQL Server 2017 or newer 


## Installation

1. Download bcpToolkit and run installer. You may need to unblock the exe before running the installer.
2. Download the "powerShell Extension (PSE) for powerLoad" from the [Release](../../releases) area and the run installer. You may need to unblock the MSI before running the installer.
3. Create a new PowerShell script or use a sample from the [Samples](https://github.com/coolOrangeLabs/powerLoadPublic/tree/main/Samples) folder.


## Functions overview
The powerLoad extension provides the following CmdLets: <br>

- [**Connect-powerLoadDatabase**](./CmdLets/doc/Connect-PowerLoadDatabase.md): Creates or opens the powerLoad database
- [**Import-BCP**](./CmdLets/doc/Import-BCP.md): Imports the BCP packages into the powerLoad database.
- [**Import-FilesToDatabase**](./CmdLets/doc/Import-FilesToDatabase.md): Imports the files into the powerLoad database
- [**Get-VaultData**](./CmdLets/doc/Get-VaultData.md): Imports data from Vault using a saved search
- [**Invoke-PowerLoadSql**](./CmdLets/doc/Invoke-PowerLoadSql.md): Executes SQL statements to manipulate the data
- [**Import-InventorProperties**](./CmdLets/doc/Import-InventorProperties.md): Imports specified Inventor Properties of database files
- [**Add-PowerLoadUDP**](./CmdLets/doc/Add-PowerLoadUDP.md): Adds a user defined property to the powerLoad database.
- [**Remove-PowerLoadUDP**](./CmdLets/doc/Remove-PowerLoadUDP.md): Removes a user defined property from the powerLoad database.
- [**Rename-PowerLoadUDP**](./CmdLets/doc/Rename-PowerLoadUDP.md): Renames a user defined property in the powerLoad database.
- [**Resolve-AutoCadReferences**](./CmdLets/doc/Resolve-AutoCadReferences.md): Checks the AutoCAD references and lists the references that could not be resolved.
- [**Resolve-InventorReferences**](./CmdLets/doc/Resolve-InventorReferences.md): Checks the Inventor references using the Inventor project file and lists the references that could not be resolved.
- [**Test-PowerLoadDataBase**](./CmdLets/doc/Test-PowerLoadDataBase.md): Tests the powerLoad database for errors.
- [**Test-PowerLoadVaultBehaviors**](./CmdLets/doc/Test-PowerLoadVaultBehaviors.md): Tests your powerLoad data against your target Vault behaviors (configuration)
- [**Export-BCP**](./CmdLets/doc/Export-BCP.md): Creates a DTU/BCP package


## Quick start

Create a PowerShell Script, copy this code, and adapt and extend as needed.
```PowerShell
$VaultVersion = "2025"                                                            #Version of target Vault
$powerLoadPath = "C:\Program Files\coolOrange\powerload\Vault_" + $VaultVersion   #path to the powerLoad DLL
Import-Module ($powerLoadPath + "\powerload.psd1") 
Connect-powerLoadDatabase -Server "MYSERVER\MYSQLINSTANCE" -DatabaseName "pl-test" -User "sa" -Password 'MySAPassword' #connect to database 

$exportPath = "c:\temp\test_export"                                               #path to where the DTU (BCP) package shall be created; path must exist

#region File Import to IDB
### Set folders for import 
$ImportPath = "C:\Data\LegacyFilestore"
$rootDirectories = @{"C:\Data\LegacyFilestore\Designs" = "$/Designs"; "C:\Data\LegacyFilestore\Content Center Files" = "$/Content Center Files" }    #specify root folders in Vault
$ExcludeFolders = @("OLDVERSIONS", "OBSOLETE", "Presets")     ## Caution! This also exclude filnames with these strings
$ExcludeFoldersFull = $ExcludeFolders -join '|'
$IncludeFileExtensions = @("*.ipt", "*.iam", "*.idw", "*.ipn", "*.dwg", "*.dwf", "*.xls", "*.xlsx", "*.doc", "*.docx", "*.fres", "*.fsat", "*.fwiz")
$result = Get-ChildItem -Path $ImportPath -File -Recurse -Include $IncludeFileExtensions | Where-Object {$_.FullName -notmatch $ExcludeFoldersFull} | Import-FilesToDatabase -FileObject -rootDirectories $rootDirectories -ErrorCSVPath ($exportPath + "ImportInIDB_errors.csv") 
#endregion File Import to IDB

$projectFile = "C:\Data\LegacyFilestore\Designs.ipj"           #Inventor project file to resolve legacy data
$refCheck = Resolve-InventorReferences -InventorProjectFile $projectFile -ErrorCSVPath "$exportPath\RefErrors.csv"

$dbCheck = Test-PowerLoadDataBase -ErrorCSVPath "$exportPath\dbErrors.csv"

$vaultCheck = Test-PowerLoadVaultBehaviors -Server "localhost" -Vault "Vault" -User "Administrator" -Password "" -ErrorCSVPath "$exportPath\vaultErrors.csv"

Export-BCP -ExportDirectory $exportPath
```

## Please Note:

This software is not fully tested or officially supported. It should be used at your own risk. While coolOrange invests significant effort in delivering a stable, high-performing, and comprehensive solution, we acknowledge that the software may have issues.

### Using this software:

We strongly recommend collaborating with coolOrange when utilizing this software to ensure that we can work together to address any problems that may arise. While coolOrange is committed to enhancing and rectifying the software, there is no guarantee regarding the timing or certainty of these improvements.
