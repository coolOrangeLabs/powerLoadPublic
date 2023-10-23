---
external help file: powerload.dll-Help.xml
Module Name: powerload
online version:
schema: 2.0.0
---

# Test-PowerLoadDataBase

## SYNOPSIS
Tests the PowerLoad database for errors

## SYNTAX

```
Test-PowerLoadDataBase [-ErrorCSVPath <String>] [<CommonParameters>]
```

## DESCRIPTION
Tests the PowerLoad database for errors and returns a CSV file with the results.
It also returns an object with the error and warning count.

## EXAMPLES

### Example 1
```powershell
PS C:\> Test-PowerLoadDataBase
```

Tests the PowerLoad database for errors and returns an object with the error and warning count.

### Example 2
```powershell
PS C:\> Test-PowerLoadDataBase -ErrorCSVPath C:\Temp\PowerLoadErrors.csv
```

Tests the PowerLoad database for errors and returns an object with the error and warning count and saves the errors to a CSV file.

## PARAMETERS

### -ErrorCSVPath
Path to save the errors to.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
