---
external help file: ResolveInventorReferences.dll-Help.xml
Module Name: powerLoad
online version:
schema: 2.0.0
---

# Resolve-InventorReferences

## SYNOPSIS
Ivestigates the Inventor file references

## SYNTAX

```
Resolve-InventorReferences [-InventorProjectFile] <String> [[-AlternativePaths] <Hashtable>]
 [[-ErrorCSVPath] <String>] [-InitialRun <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
Checks all files in the powerLoad database with ContentSource Inventor and stores the resovlable references into the powerLoad database. Reference which cannot be resolved will be written to the ErrorCsvFile. Additionally, for missing/unknown references it also creates 'UnknownFileFileRelations' table.

## EXAMPLES

### Example 1
```powershell
PS C:\> Resolve-InventorReferences -InventorProjectFile 'C:\temp\Project.ipj' -ErrorCSVPath 'C:\temp\Errors.csv'
```

Tries to resolve the references with the given project file. If any Errors occure, they will be written into the ErrorsCSVPath.

### Example 2
```powershell
PS C:\> Resolve-InventorReferences -InventorProjectFile 'C:\temp\Project.ipj' -AlternativePaths @{"C:\temp" = "C:\User"}
```

Tries to resolve the references with the given project file. If any files could not be found in the C:\temp directory, they will be searched in the C:\User directory.

## PARAMETERS

### -AlternativePaths
A Hashtable of alternative Paths. Example: @{"path1" = "path2"}

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

### -ErrorCSVPath
Path to the CSv File where all the Errors are listed. Example: "C:\temp\Errors.csv"

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

### -InventorProjectFile
The path to the Inventor project file. Example: "C:\User\Downloads\Project.ipj"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InitialRun
{{ Fill InitialRun Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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
