---
external help file: powerload.dll-Help.xml
Module Name: powerload
online version:
schema: 2.0.0
---

# Import-FilesToDatabase

## SYNOPSIS
Pupulates the powerLoad database with folders and files from the given list of files

## SYNTAX

```
Import-FilesToDatabase [-Files] <String[]> [-AddVersions] [[-FileCategory] <String>]
 [[-FileRevisionDefinition] <String>] [[-FileLifeCycleState] <String>] [[-FileLifeCycleDefinition] <String>]
 [[-FileRevisionLabel] <String>] [[-FileClassification] <String>] [[-FileCreateUser] <String>]
 [[-ErrorCSVPath] <String>] [[-rootDirectories] <Hashtable>] [[-FolderCategory] <String>]
 [[-FolderCreateUser] <String>] [<CommonParameters>]
```

## DESCRIPTION
Pupulates the powerLoad database with folders and files from the given list of files and sets the NeedsReferenceAnalysis to 1 for new files.
It checks whether the file exists and read permissions are granted.
If same file is imported, it checks whether the last modified date and the file size are the same. If not, it treats the file like an update or new revision, updates the database and sets the NeedsReferenceAnalysis to 1

## EXAMPLES

### Example 1
```powershell
PS C:\> $files = Get-ChildItem -Path 'C:\temp\Files' -Recurse
		$pathsArray = $files | ForEach-Object { $_.FullName }
		Import-FilesToDatabase -Files $pathsArray 
```

Gets All the Files in the Path C:\temp\Files and Imports them into your IDB with the Dafault Values.

### Example 2
```powershell
PS C:\> $files = Get-ChildItem -Path 'C:\temp\Files' -Recurse
		$pathsArray = $files | ForEach-Object { $_.FullName }
		Import-FilesToDatabase -Files $pathsArray -AddVersions -ErrorCSVPath 'C:\temp\Errors.csv' -FileCreateUser 'Daniel' -FileLifeCycleState 'Finish'
```

Gets All the Files in the Path C:\temp\Files and Imports them into your IDB with the given Values. If any errors occure, they will be written into the File C:\temp\Errors.csv. When there are some changes in a file, a new version will be added.

## PARAMETERS

### -AddVersions
Treats a file change/update as a new version

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ErrorCSVPath
The Path for the CSV File with all Errors in it. Example: "C:\temp\Vault\Errors.csv"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FileCategory
Vault file category for all imported files. Default: "Engineering"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FileClassification
Vault classification for all imported files. Default: "NONE"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FileCreateUser
Vault create user for all imported files. Default: "Migraftion"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FileLifeCycleDefinition
Vault lifecycle definition for all imported files. Default: "Flexible Release Process"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FileLifeCycleState
Vault lifecycle state for all imported files. Default: "Work in Progress"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FileRevisionDefinition
Vault revision definition for all imported files. Default: "Standard Alphabetic Format"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FileRevisionLabel
Vault revision label for all imported files. Default: A

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Files
The Files to Import. Example: $files

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FolderCategory
Vault category for all imported folders. Default: "Folder"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FolderCreateUser
Vault create user for all imported folders. Default: "Migration"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -rootDirectories
Specify Rootdirectories which get replaced by $. Example: @{"C:\TEMP\sample" = "$"}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
