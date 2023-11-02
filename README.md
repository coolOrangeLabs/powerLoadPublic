# POWERLOAD 

This PowerShell extension for powerLoad, is designed to streamline and automate various tasks related to data loading into Vault using the Autodesk DTU (aka. BCP).

## Prerequisites

Operating System: Windows

Installed Program: Autodesk Vault, coolOrange powerLoad ([download](https://www.coolorange.com/powerload-download-page))

Database: MS SQL Server. 


## Installation

1. Download the Zip-File for your Vault version from the [Release](../../releases) area
2. Extract the Zip-File into a local folder of your choice
3. If necessary, unblock all .dll Files or Run the script as Administrator (select all files, right click > properties, unblock)
4. Create a new PowerShell script or use a sample fromthe [Samples](https://github.com/coolOrangeLabs/powerLoadPublic/tree/main/Samples) folder

## Usage
The powerLoad extension provides the following CmdLets: <br>

- [**Connect-powerLoadDatabase**](./CmdLets/doc/Connect-PowerLoadDatabase.md): Creates or opens the powerLoad database
- [**Import-BCP**](./CmdLets/doc/Import-BCP.md): Imports the BCP packages into the powerLoad database.
- [**Import-FilesToDatabase**](./CmdLets/doc/Import-FilesToDatabase.md): Imports the files into the powerLoad database
- [**Invoke-PowerLoadSql**](./CmdLets/doc/Invoke-PowerLoadSql.md): Executes SQL statements to manipulate the data
- [**Add-PowerLoadUDP**](./CmdLets/doc/Add-PowerLoadUDP.md): Adds a user defined property to the powerLoad database.
- [**Remove-PowerLoadUDP**](./CmdLets/doc/Remove-PowerLoadUDP.md): Removes a user defined property from the powerLoad database.
- [**Rename-PowerLoadUDP**](./CmdLets/doc/Rename-PowerLoadUDP.md): Renames a user defined property in the powerLoad database.
- [**Resolve-InventorReferences**](./CmdLets/doc/Resolve-InventorReferences.md): Retrieves the Inventor project file from the specified location.
- [**Test-PowerLoadDataBase**](./CmdLets/doc/Test-PowerLoadDataBase.md): Tests the powerLoad database for errors.
- [**Test-PowerLoadVaultBehaviors**](./CmdLets/doc/Test-PowerLoadVaultBehaviors.md): Tests your powerLoad data against your target Vault configuration
- [**Export-BCP**](./CmdLets/doc/Export-BCP.md): Creates a BCP package


## Please Note:

This software is not fully tested or officially supported. It should be used at your own risk. While coolOrange invests significant effort in delivering a stable, high-performing, and comprehensive solution, we acknowledge that the software may have issues.

### Using this software:

We strongly recommend collaborating with coolOrange when utilizing this software to ensure that we can work together to address any problems that may arise. While coolOrange is committed to enhancing and rectifying the software, there is no guarantee regarding the timing or certainty of these improvements.
