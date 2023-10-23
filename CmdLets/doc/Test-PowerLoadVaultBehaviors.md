---
external help file: powerload.dll-Help.xml
Module Name: powerload
online version:
schema: 2.0.0
---

# Test-PowerLoadVaultBehaviors

## SYNOPSIS
Tests if the Data in hte Database matches the behaviors of the Vault

## SYNTAX

```
Test-PowerLoadVaultBehaviors [-ErrorCSVPath <String>] [-Server <String>] [-Vault <String>] [-User <String>]
 [-Password <String>] [<CommonParameters>]
```

## DESCRIPTION
Tests if the Data in hte Database matches the behaviors of the Vault and outputs a CSV with the results.
It also returns an object with the error and warning counts.

## EXAMPLES

### Example 1
```powershell
PS C:\> Test-PowerLoadVaultBehaviors -Server "localhost" -Vault "Vault" -User "Administrator" -Password "Password" 
```

Tests the Vault "Vault" on the Server "localhost" with the User "Administrator" and the Password "Password" and returns the results as an object.

### Example 2
```powershell
PS C:\> Test-PowerLoadVaultBehaviors -Server "localhost" -Vault "Vault" -User "Administrator" -Password "Password" -ErrorCSVPath "C:\Temp\Errors.csv"
```

Tests the Vault "Vault" on the Server "localhost" with the User "Administrator" and the Password "Password" and returns the results as an object and writes the errors to the file "C:\Temp\Errors.csv".

### Example 3
```powershell
PS C:\> Test-PowerLoadVaultBehaviors
```
Uses the default values to test the Vault "Vault" on the Server "localhost" with the User "Administrator" and no Password and returns the results as an object.

## PARAMETERS

### -ErrorCSVPath
Path to save the errors to

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

### -Password
Password for the User

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

### -Server
Server of the Vault

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: localhost
Accept pipeline input: False
Accept wildcard characters: False
```

### -User
User for the Vault

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Administrator
Accept pipeline input: False
Accept wildcard characters: False
```

### -Vault
Vault to test

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Vault
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
