---
external help file: powerload.dll-Help.xml
Module Name: powerload
online version:
schema: 2.0.0
---

# Rename-PowerLoadUDP

## SYNOPSIS
Renames the User Defined Property in the powerLoad database

## SYNTAX

```
Rename-PowerLoadUDP [-Entity] <String> [-NewName] <String> [-OldName] <String> [<CommonParameters>]
```

## DESCRIPTION
Renames the User Defined Property in the powerLoad database. If the property does not exists, a warning will be displayed, no error.

## EXAMPLES

### Example 1
```powershell
Rename-PowerLoadUDP -Entity Files -OldName 'test' -NewName 'bla'
```

The property 'test' will be renamed to 'bla'. The type will remain unchanged.

## PARAMETERS

### -Entity
Defines the entity for which you like to add the UDP

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Files, Folders, Items, CustomObjects

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NewName
The new name of the UDP

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OldName
The old name of the UDP

```yaml
Type: String
Parameter Sets: (All)
Aliases:

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
