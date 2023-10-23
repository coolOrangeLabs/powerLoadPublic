---
external help file: powerload.dll-Help.xml
Module Name: powerload
online version:
schema: 2.0.0
---

# Invoke-PowerLoadSql

## SYNOPSIS
Executes SQL statements on the specified database connection.

## SYNTAX

```
Invoke-PowerLoadSql [[-Statement] <String>] [[-ScriptPath] <String>] [-OutputAsTable] [<CommonParameters>]
```

## DESCRIPTION
Executes SQL statements on the specified database connection.
If not connected to the Database, the Program will return an Error.

## EXAMPLES

### Example 1
```powershell
PS C:\> Invoke-PowerLoadSql -Statement 'SELECT * FROM Files' 
```

Executes the SQL Statement 'SELECT * FROM Files' and prints out every match.

### Example 2
```powershell
PS C:\> Invoke-PowerLoadSql -ScriptPath 'C:\temp\script.sql'
```

Executes the given SQl script.

## PARAMETERS

### -OutputAsTable
Speciffies if the Output should be a table. Default false

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

### -ScriptPath
The path to the SQL script file. Example: "C:\User\Scripts\script.sql"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Statement
The SQL statement to execute. Example: "SELECT * FROM TableName"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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
