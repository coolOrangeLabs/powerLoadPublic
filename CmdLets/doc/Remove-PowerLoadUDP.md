---
external help file: RemovePowerLoadUDP.dll-Help.xml
Module Name: powerLoad
online version:
schema: 2.0.0
---

# Remove-PowerLoadUDP

## SYNOPSIS
Removes the User Defined Property from the powerLoad database

## SYNTAX

```
Remove-PowerLoadUDP [-Name] <String> [-Entity] <String> [<CommonParameters>]
```

## DESCRIPTION
Removes the UDP from the powerLoad database from the given entity (table)

## EXAMPLES

### Example 1
```powershell
Remove-PowerLoadUDP -Entity Files -Name 'test'
```

The property test from the entity Files will be removed from the powerLoad database. In case the property does not exist, no information will be prompted.

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
Defines the name of the UDP

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
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
