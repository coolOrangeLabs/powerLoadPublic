Import-Module "c:\temp\powerLoad\v3\powerload.dll"

# define your import and export paths
$importPath = "C:\Autodesk\autodesk_inventor_2019_samples_sfx\Models\Assemblies\Scissors"
$exportPath = "c:\temp\test_export"

# define your database connection
Connect-powerLoadDatabase -Server "MARCOMIRAND7E20\POWERLOAD" -DatabaseName "test" -User "sa" -Password "coo!Orange" #-ForceDatabaseCreation

# collect all files from the import path
$files = Get-ChildItem -Path $importPath -File -Recurse -Exclude *.bak, *.lck, OldVersions
# define the Vault root directories for the import
$rootDirectories = @{"$importPath"='$/Designs/Scissors'}
$result = Import-FilesToDatabase -Files $files.FullName -rootDirectories $rootDirectories -ErrorCSVPath "$exportPath\importErrors.csv"
if($result.Errors -gt 0) { throw("Import errors found") }

# add your database maniuplations
Invoke-PowerLoadSql -Statement "UPDATE Files SET Category='Engineering' WHERE FileExtension IN ('iam','ipn','ipt','idw','dwg')"
# add a custom property and fill them as needed
Add-PowerLoadUDP -Entity Files -Type Text -Name "Test"
Invoke-PowerLoadSql -Statement "UPDATE Files SET Test='test'"

# in case you have references errors, the alternative path may help you resolve them
$alternativePaths = @{
'C:\Users\itools\Desktop\autodesk_inventor_2018_samples\Models\Assemblies\Scissors\Components'='C:\Autodesk\autodesk_inventor_2019_samples_sfx\Models\Assemblies\Scissors\_Components'
'C:\Autodesk\autodesk_inventor_2019_samples_sfx\Models\Assemblies\Scissors\Components\_blade_main.ipt'='C:\Autodesk\autodesk_inventor_2019_samples_sfx\Models\Assemblies\Scissors\Components\blade_main.ipt'
}

# specify your Inventor project file
$projectFile = "$importPath\..\..\..\samples.ipj"
# check for reference errors
$refCheck = Resolve-InventorReferences -InventorProjectFile $projectFile -AlternativePaths $alternativePaths -ErrorCSVPath "$exportPath\RefErrors.csv"
if($refCheck.Errors -gt 0) { throw("Reference errors found") }

$dbCheck = Test-PowerLoadDataBase -ErrorCSVPath "$exportPath\dbErrors.csv"
if($dbCheck.Errors -gt 0) { throw("Database errors found") }

$vaultCheck = Test-PowerLoadVaultBehaviors -Server "localhost" -Vault "Vault" -User "Administrator" -Password "" -ErrorCSVPath "$exportPath\vaultErrors.csv"
if($vaultCheck.Errors -gt 0) { throw("Vault errors found") }

if(Test-Path $exportPath) { Remove-Item $exportPath -Force -Recurse }
Export-BCP -ExportDirectory $exportPath