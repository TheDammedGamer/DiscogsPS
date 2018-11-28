#API Pattern
#https://api.discogs.com/releases/{release_id}{?curr_abbr}

#curr_abbr
#Allowed Items = USD GBP EUR CAD AUD JPY CHF MXN BRL NZD SEK ZAR


function Get-DiscogsPSRelease {
    [CmdletBinding()]
    [OutputType([HashTable])]
    param (
        [Parameter(Position=0, Mandatory=$true)][int]$ReleaseID,
        [Parameter(Position=1, Mandatory=$false)][string]$Token,
        [Parameter(Mandatory=$false)][ValidateSet("USD", "GBP", "EUR", "CAD", "AUD", "JPY", "CHF", "MXN", "BRL", "NZD", "SEK", "ZAR")][string]$CurrencyAbbrv
    )

    begin {
        $URIargs = @()

        $URI = 'https://api.discogs.com/releases/{release_id}'
        if ($ReleaseID -ne $null) {
            $URI = $URI.Replace('{release_id}', $ReleaseID.ToString())
            Write-Verbose -Message "Release ID: $ReleaseID"
        } else {
            throw "No Release Specified Please specify via '-ReleaseID' specifiying a valid release id number "
        }

        if ($token.trim() -ne '') {
            $URIargs += Add-URIArgument -Key 'token' -Value $token.trim()
        }
        if ($CurrencyAbbrv.trim() -ne '') {
            $URIargs += Add-URIArgument -Key 'curr_abbr' -Value $CurrencyAbbrv.trim()
        }

        $URI = Convert-URIArguments -URI $URI -URIArgs $URIargs
    }

    process {
        try {
            $resp = Invoke-WebRequest -Uri $URI -UseBasicParsing -Method GET
        }
        catch {
            if (($resp.StatusCode -eq 404) -and ($($resp.Content | ConvertFrom-Json).message -eq 'Release not found.' )) {
                throw "Release not found on Discogs."
            } elseif ($resp.StatusCode -eq 404) {
                throw "Error 404 from Discogs API Check Connection to https://api.discogs.com"
            } else {
                throw $_
            }
        }
    }

    end {
        #return [DiscogsArtist]::new($resp.Content)
        return $resp.Content
    }
}