---
external help file: ResolveAutoCADReferences.dll-Help.xml
Module Name: powerLoad
online version:
schema: 2.0.0
---

# Resolve-AutoCADReferences

## SYNOPSIS
Investigates the AutoCAD xrefs and creates the references within the powerLoad database.

## SYNTAX

```
Resolve-AutoCADReferences [-AcCoreConsolePath <String>] [-AlternativePaths <Hashtable>]
 [[-ErrorCSVPath] <String>] [<CommonParameters>]
```

## DESCRIPTION
Tries to resolve the AutoCAD xrefs of the AutoCAD files present in the powerLoad database and saves the references into the powerLoad database. Reference which cannot be resolved will be written to the ErrorCsvFile.
Additionally, for missing/unknown references it also creates 'UnknownFileFileRelations' table.

## EXAMPLES

### Example 1
```powershell
PS C:\> Resolve-AutoCADReferences -ErrorCSVPath C:\temp\autoCAD.csv
```

References which can be resolved will be written into the powerLoad database. Not resolved references will be writte to the log file.

## PARAMETERS

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

### -AcCoreConsolePath

Specifies the path to the AutoCAD Core Console executable. This is an optional parameter.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AlternativePaths
A Hashtable of alternative Paths. Example: @{"path1" = "path2"} This is an optional parameter. This parameter is not used in the current version of the cmdlet.

```yaml
Type: Hashtable
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
