---
external help file: ImportFilesToDatabase.dll-Help.xml
Module Name: powerload
online version:
schema: 2.0.0
---

# Import-FilesToDatabase

## SYNOPSIS
Pupulates the powerLoad database with folders and files from the given list of files.

## SYNTAX

### FilePathString
```
Import-FilesToDatabase -FullName <String> [-FileName] [[-rootDirectories] <Hashtable>] [-AddVersions]
 [-AddUsers] [[-ErrorCSVPath] <String>] [-ChunkingSize <Int32>] [<CommonParameters>]
```

### plFileInfo
```
Import-FilesToDatabase -coFileInfo <Hashtable> [-plFileInfo] [[-rootDirectories] <Hashtable>] [-AddVersions]
 [-AddUsers] [[-ErrorCSVPath] <String>] [-ChunkingSize <Int32>] [<CommonParameters>]
```

### FileInfoObject
```
Import-FilesToDatabase -File <FileInfo> [-FileObject] [[-rootDirectories] <Hashtable>] [-AddVersions]
 [-AddUsers] [[-ErrorCSVPath] <String>] [-ChunkingSize <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Populates a powerLoad database with folders and files that are piped into the cmdlet and sets NeedsReferenceAnalysis to 1 for new files.
If the same file is imported and the modified date and file size are not the same, it treats the imported file as a new revision, updates the database, and sets NeedsReferenceAnalysis to 1 

## EXAMPLES

### Example 1
```
powershell
PS C:\> Get-ChildItem -Path 'C:\temp\Files' -File -Recurse |
ForEach-Object -Process {
    @{"Name" = $_.Name; 
    "FullName" = $_.FullName;
    "Extension" = $_.Extension;
    "CreationTime" = $_.CreationTimeUtc;
    "LastWriteTime" = $_.LastWriteTimeUtc;
    "Length" = $_.Length }
}|Import-FilesToDatabase -plFileInfo -AddVersions -ErrorCSVPath 'C:\temp\Output\Error.csv'
```

Gets all the files in the path C:\temp\Files and Imports them into your IDB with default values.
Outputs an Error log to C:\temp\Output\Error.csv. When there are some changes in a file, a new version will be added.

### Example 2

```powershell
PS C:\> Get-ChildItem -Path $ImportPath -File -Recurse | 
        Import-FilesToDatabase -FileObject
```

Imports files into database at location $ImportPath. Takes in FileInfo objects.

## PARAMETERS

### -FileName

Dictates that you are passing in the names of Files. Not recommended, as you can run into file security issues and some locations may have IT issues.

```yaml
Type: SwitchParameter
Parameter Sets: FilePathString
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -plFileInfo

Dictates that you are passing in a hashtable of relevant values.

```yaml
Type: SwitchParameter
Parameter Sets: plFileInfo
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FileObject

Dictates that you are passin in FileInfo objects

```yaml
Type: SwitchParameter
Parameter Sets: FileInfoObject
Aliases:

Required: False
Position: Named
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

### -AddUsers
Includes file author as the creation user

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

### -ChunkingSize
Specifies the size of the chunks in which the files are processed. This is useful when dealing with a large number of files to avoid memory issues and improve performance. Default value is set to 1000.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -coFileInfo
Specifies hashtable that contains relevant values for importing files into the database. This parameter is used when using the plFileInfo parameter set. The hashtable should contain keys such as "Name", "FullName", "Extension", "CreationTime", "LastWriteTime", and "Length".

```yaml
Type: Hashtable
Parameter Sets: plFileInfo
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -File
Specifies the FileInfo object that contains the file information to be imported into the database. This parameter is required when using the FileInfoObject parameter set.


```yaml
Type: FileInfo
Parameter Sets: FileInfoObject
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -FullName
Specifies the full path of the file to be imported into the database. This parameter is required when using the FilePathString parameter set.

```yaml
Type: String
Parameter Sets: FilePathString
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
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
