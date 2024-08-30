---
external help file: powerload.dll-Help.xml
Module Name: powerload
online version:
schema: 2.0.0
---

# Import-BCP

## SYNOPSIS
Imports the BCP packages to the target location.

## SYNTAX

```
Import-BCP [-ImportPath] <String> [-SkipFiles] [-SkipItems] [<CommonParameters>]
```

## DESCRIPTION
Imports the BCP packages to the target location.
If not connected to the Database, the Program will return an Error.
If used on huge databases, the cmdlet may run into SQL connection timeout. In this case, increase the 'CommandTimeout' in the file 'DatabaseManager.dll.config' and try again

## EXAMPLES

### Example 1
```powershell
PS C:\> Import-BCP -ImportPAth 'C:\temp\bcp'
```

Imports the BCP-Package located at C:\temp\bcp.

### Example 2
```powershell
PS C:\> Import-BCP -ImportPAth 'C:\temp\bcp' -SkipItems
```

Imports just the files from the BCP-Package located at C:\temp\bcp, and does not load the items, BOM, and item-file links.


## PARAMETERS

### -ImportPath
The path to the BCP package. Example: 'C:\temp\bcp'

### -SkipFiles
Skip the loading of Folders, Files, and References

### -SkipItems
Skip the loading of Items, BOMs, and File-Item links

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
