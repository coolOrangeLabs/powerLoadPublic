# POWERLOAD 
[![CI](https://github.com/coolOrangeLabs/powerLoad/actions/workflows/main.yml/badge.svg)](https://github.com/coolOrangeLabs/powerLoad/actions/workflows/main.yml)

powerLoad is a PowerShell extension designed to streamline and automate various tasks related to powerLoad. It provides a set of commands to simplify the management and manipulation of powerLoad- -utilities.

## Prerequisites

Operating System: Windows

Installed Program: Autodesk Vault


## Installation

1. Download the Zip-File
2. Extract the Zip-File
3. Create a new PowerShell script and paste the following code
```powershell
Import-Module "<YourPath>\powerload.dll"

Connect-powerLoadDatabase -ConnectString -Server "<YourSqlInstance>" -DatabaseName "<Database>" -User "<SqlUser>" -Password "<SqlPassword>"

$files = Get-ChildItem -Path "<Filestorepath>" -Recurse -File
$result = Import-FilesToDatabase -Files $files.FullName -ErrorCSVPath "<path>" -rootDirectories @{"<path1>" = "<root1>"}

$result = Invoke-PowerLoadSql -Statement "UPDATE Files SET Category = 'Drawings' WHERE FileExtension = 'idw';"

$alternativePaths = @{"<oldPath1>" = "<newPath1>"
"<oldPath2>" = "<newPath2>"}


$result = Resolve-InventorReferences -InventorProjectFile "<Invetorprojectfilepath>" -ErrorCSVPath "<path>" -AlternativePaths $alternativePaths

$result = Export-BCP -ExportDirectory "<Exportpath>"
```
4. Adapt <YourPath> to where you have extracted the ZIP, pointing to the powerLoad.dll
5. Adapt the connectstring to your database requirements
6. Unblock all .dll Files or Run the script as Administrator

## Usage
The powerLoad extension provides the following CmdLets: <br>

- **Connect-powerLoadDatabase**: Opens a connection to the specified database for powerLoad.[More Information](https://github.com/coolOrangeLabs/powerLoad/blob/main/CmdLets/doc/Connect-PowerLoadDatabase.md)
- **Import-BCP**: Imports the BCP packages to the target location. [More Information](https://github.com/coolOrangeLabs/powerLoad/blob/main/CmdLets/doc/Import-BCP.md)
- **Import-FilesToDatabase**: Copies the file names and folder names from the specified source directory to the configured powerLoad database. [More Information](https://github.com/coolOrangeLabs/powerLoad/blob/main/CmdLets/doc/Import-FilesToDatabase.md)
- **Test-PowerLoadDataBase**: Tests the PowerLoad database for errors. [More Information](https://github.com/coolOrangeLabs/powerLoad/blob/main/CmdLets/doc/Test-PowerLoadDataBase.md)
- **Resolve-InventorReferences**: Retrieves the Inventor project file from the specified location. [More Information](https://github.com/coolOrangeLabs/powerLoad/blob/main/CmdLets/doc/Resolve-InventorReferences.md)
- **Test-PowerLoadVaultBehaviors**: Tests if the Data in hte Database matches the behaviors of the Vault. [More Information](https://github.com/coolOrangeLabs/powerLoad/blob/main/CmdLets/doc/Test-PowerLoadVaultBehaviors.md)
- **Export-BCP**: Selects and exports translations based on the specified connection string and export directory. Converts the data from the IDB to a Bcp package. [More Information](https://github.com/coolOrangeLabs/powerLoad/blob/main/CmdLets/doc/Export-BCP.md)
- **Invoke-PowerLoadSql**: Executes SQL statements on the specified database connection. [More Information](https://github.com/coolOrangeLabs/powerLoad/blob/main/CmdLets/doc/Invoke-PowerLoadSql.md)


## Sample for first customer analysis

```powershell
Import-Module "<YourPath>\powerload.dll"

Connect-powerLoadDatabase

$files = Get-ChildItem -Path '<YourfolderToImport>' -File -Recurse
Import-FilesToDatabase -Files $files.FullName -ErrorCSVPath "$($env:TEMP)\powerLoad\importErrors.csv"

$projectFile = '<YourInventorProjectFile>'
Resolve-InventorReferences -InventorProjectFile $projectFile -ErrorCSVPath "$($env:TEMP)\powerLoad\RefErrors.csv"

Invoke-Item "$($env:TEMP)\powerLoad"
```
