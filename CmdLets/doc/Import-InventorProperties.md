---
external help file: ImportInventorProperties.dll-Help.xml
Module Name: powerLoad
online version:
schema: 2.0.0
---

# Import-InventorProperties

## SYNOPSIS
Imports specified Inventor Properties of database files where the value of column "ImportProperties" is 1.

## SYNTAX

```
Import-InventorProperties -Properties <Hashtable> [<CommonParameters>]
```

## DESCRIPTION
Imports specified Inventor Properties of database files where the value of column "ImportProperties" is 1.
If a db column or a property of a file, or a file cannot be readed, you will get the corresponding error/warn messange in the console.
When the file is closed the ImportProperties column related to the file will be set to 0.

## EXAMPLES

### Example 1
```
PS C:\> Import-InventorProperties -Properties  @{"Author" = "CreateUser"}
```

Imports the Inventor Property "Author" to the existing database column "CreateUser"

### Example 2
```
PS C:\> Import-InventorProperties -Properties  @{"Creation Time" = "UDP_MyDate";"custom:customBoolean" = "UDP_MyBool"}
```

Imports the Inventor Property "Creation Time" to the database column "UDP_MyDate" and a custom Inventor Property "customBoolean" to the database column "UDP_MyBool"

## PARAMETERS

### -Properties
Hashtable that contains the relation the InventorPropety Name as the key and the column name in the database as the value. You can specify custom Inventor Properties if you the prefix "custom:" before the property name.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: True
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

### None
## NOTES

## RELATED LINKS
