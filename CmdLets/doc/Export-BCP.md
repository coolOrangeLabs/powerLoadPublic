---
external help file: powerload.dll-Help.xml
Module Name: powerload
online version:
schema: 2.0.0
---

# Export-BCP

## SYNOPSIS
Exports the Data from the IDB to a BCP-Package.

## SYNTAX

```
Export-BCP [-ExportDirectory] <String> [[-VaultVersion] <String>] [[-DisableConfig] <Boolean>]
 [[-BcpVersion] <String>] [-ServerName <String>] [-VaultName <String>] [-User <String>] [-Password <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Exports the Data from the IDB to a BCP-Package.
If not connected to the Database, the Program will return an Error.
If the ExportDirectory does not exist, it will be created.
If the VaultConnection is successful, the Export will produce a delta BCP-Package.
If used on huge databases, the cmdlet may run into SQL connection timeout. In this case, increase the 'CommandTimeout' in the file 'DatabaseManager.dll.config' and try again

## EXAMPLES

### Example 1
```powershell
PS C:\> Export-BCP -ExportDirectory 'C:\temp\bcp' -VaultVersion '2019'
```

Creates a BCP-Package at 'C:\temp\bcp' and configerates it for Vault 2019.

### Example 2
```powershell
PS C:\> Export-BCP -ExportDirectory 'C:\temp\bcp' -DisableConfig 0 -BcpVersion '2017'
```

Creates a BCP-Package at 'C:\temp\bcp' and enables Configuration and uses the BCPToolkit 2017.

### Example 3
```powershell
PS C:\> Export-BCP -ExportDirectory 'C:\temp\bcp' -VaultVersion '2019' -ServerName 'localhost' -VaultName 'Vault' -User 'Administrator' -Password ''
```

Creates a delta BCP-Package at 'C:\temp\bcp' and configerates it for Vault 2019.

## PARAMETERS

### -BcpVersion
The version of BcpToolkit. Default: "2020"

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

### -DisableConfig
Specifies whether to disable the configuration. Default: true

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExportDirectory
The directory to export the translations. Example: "C:\Temp\Translate"

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

### -VaultVersion
The version of Autodesk Vault. For any Vault Version above 2020 use 2020 Default: "2020"

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

### -Password
Password for the Vault User.

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

### -ServerName
The name of the Vault Server. 

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

### -User
The name of the Vault User.

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

### -VaultName
The name of the Vault.

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
