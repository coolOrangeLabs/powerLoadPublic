---
external help file: powerload.dll-Help.xml
Module Name: powerload
online version:
schema: 2.0.0
---

# Get-VaultData

## SYNOPSIS
Fills the powerLoad database from a Vault saved search 

## SYNTAX

```
Get-VaultData [-VaultServer] <String> [-VaultName] <String> [-Username] <String> [-Password] <String> [-SearchName] <String> [[-DownloadPath] <String>] [[-ExactVersionOnly]] [<CommonParameters>]
```

## DESCRIPTION
Fills the powerLoad database from a Vault saved search 

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-VaultData -VaultServer 'localhost' -VaultName 'Vault' -Username 'Administrator' -Password '' -SearchName 'Tuner' -DownloadPath 'c:\temp\tuner' -ExactVersionOnly
```

Gets the Vault data from a search called 'Tuner', fills the powerLoad database, and downloads the files to the folder 'c:\temp\tuner'. The switch -ExactVersionOnly defined that just the latest and according necessary exact versions are take from Vault.


## PARAMETERS

### -VaultServer
Defines the Vault server for the connection

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

### -VaultName
Defines the Vault name for the connection

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

### -Username
Defines the Vault user name for the connection

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

### -Password
Defines the Vault password for the connection

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

### -SearchName
Defines the name of the Vault saved search

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

### -DownloadPath
Defines where the files shall be downloaded. If omitted, only the data from Vault will be loaded into the powerLoad database

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

### -ExactVersionOnly
Defines whether just he latest version or the required exact version of the files will be loaded into the powerLoad database. If omitted, all version of all files and related files will be loaded into the powerLoad database



### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES
- Just supports files


## RELATED LINKS
