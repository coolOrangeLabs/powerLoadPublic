---
external help file: powerload.dll-Help.xml
Module Name: powerload
online version:
schema: 2.0.0
---

# Add-PowerLoadUDP

## SYNOPSIS
Adds a User Defined Property to the powerLoad database

## SYNTAX

```
Add-PowerLoadUDP [-Name] <String> [-Entity] <String> [-Type] <String> [<CommonParameters>]
```

## DESCRIPTION
Adds a column to the powerLoad database called UDP_<Name>. If the column already exists, you'll get a warning, but no error.

## EXAMPLES

### Example 1
```powershell
PS C:\> Add-PowerLoadUDP -Entity Files -Name 'test' -Type Text
```

Adds a User Defined Property to the Files table of the powerLoad database


## PARAMETERS

### -Entity
Defines the entity for which you like to add the UDP

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Files, Folders, Items, CustomObjects

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Defined the name of the UDP. 

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

### -Type
Defines the type of the UDP

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Text, Number, Date, Boolean

Required: True
Position: 2
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
