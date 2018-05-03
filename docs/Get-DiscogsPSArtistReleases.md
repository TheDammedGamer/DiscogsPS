---
external help file: DiscogsPS-help.xml
Module Name: DiscogsPS
online version:
schema: 2.0.0
---

# Get-DiscogsPSArtistReleases

## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

```
Get-DiscogsPSArtistReleases [[-ArtistID] <Int32>] [[-FromArtist] <DiscogsArtist>] [-Token <String>]
 [-SortBy <String>] [-SortOrder <String>] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -ArtistID
{{Fill ArtistID Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: ID

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FromArtist
{{Fill FromArtist Description}}

```yaml
Type: DiscogsArtist
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -SortBy
{{Fill SortBy Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: year, title, format

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SortOrder
{{Fill SortOrder Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: asc, desc

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Token
{{Fill Token Description}}

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### DiscogsArtist


## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
