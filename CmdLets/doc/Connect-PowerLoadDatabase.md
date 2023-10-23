---
external help file: powerload.dll-Help.xml
Module Name: powerload
online version:
schema: 2.0.0
---

# Connect-PowerLoadDatabase

## SYNOPSIS
Connects to the PowerLoad database.

## SYNTAX

```
Connect-PowerLoadDatabase [[-ConnectString] <String>] [-ForceDatabaseCreation] [[-Server] <String>]
 [[-User] <String>] [[-Password] <String>] [[-DatabaseName] <String>] [<CommonParameters>]
```

## DESCRIPTION
Connects to the PowerLoad database.
If the database does not exist, it will be created.
If the database exists, it will be deleted and recreated if the -ForceDatabaseCreation switch is used.
If the database exists and the -ForceDatabaseCreation switch is not used, the existing database will be used.
If the -ConnectString parameter is used, the -Server, -User, -Password, and -DatabaseName parameters will be ignored.
If the -ConnectString parameter is not used, the -Server, -User, -Password, and -DatabaseName parameters are required.


## EXAMPLES

### Example 1
```powershell
PS C:\> Connect-PowerLoadDatabase -Server "VaultServer\AutodeskVault" -DatabaseName "powerLoad" -User "sa" -Password "AutodeskVault@26200"
```

Connect to the Vault SQL Server and create (if not existing) a database named 'powerLoad' using the default Vault SQL Server credentials

### Example 2
```powershell
PS C:\> Connect-PowerLoadDatabase -Server "VaultServer\AutodeskVault" -DatabaseName "powerLoad" -User "sa" -Password "AutodeskVault@26200" -ForceDatabaseCreation
```

Connect to the Vault SQL Server and force the (re-)creation of a database named 'powerLoad' using the default Vault SQL Server credentials

### Example 2
```powershell
PS C:\> Connect-PowerLoadDatabase -ConnectString "Server=VaultServer\AutodeskVault;Database=powerLoad;Trusted_Connection=True;"
```

Connect to the Vault SQL Server and create (if not existing) a database named 'powerLoad' using the Windows credentials

## PARAMETERS

### -ConnectString
The connection string to use to connect to the database

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

### -DatabaseName
The name of the database to connect to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ForceDatabaseCreation
Forces the database to be deleted and recreated if it already exists

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

### -Password
The password to use to connect to the database.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Server
The server name to use to connect to the database.

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

### -User
The user name to use to connect to the database.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
