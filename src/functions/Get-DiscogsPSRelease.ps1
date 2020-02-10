#API Pattern
#https://api.discogs.com/releases/{release_id}{?curr_abbr}

#curr_abbr
#Allowed Items = USD GBP EUR CAD AUD JPY CHF MXN BRL NZD SEK ZAR


function Get-DiscogsPSRelease {
    [CmdletBinding()]
    [OutputType([HashTable])]
    param (
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "ByID")]
        [int]$ReleaseID,
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "ByStub")]
        [DiscogsPS.Lib.ReleaseStub]$FromReleaseStub,

        [Parameter(Mandatory = $true, ParameterSetName = "ByID")]
        [Parameter(Mandatory = $true, ParameterSetName = "ByStub")]
        [string]$Token,

        [Parameter(Mandatory = $false, ParameterSetName = "ByID")]
        [Parameter(Mandatory = $false, ParameterSetName = "ByStub")]
        [ValidateSet("USD", "GBP", "EUR", "CAD", "AUD", "JPY", "CHF", "MXN", "BRL", "NZD", "SEK", "ZAR")]
        [string]$CurrencyAbbrv
    )

    begin {
        $URIargs = @()

        $URI = 'https://api.discogs.com/releases/{release_id}'

        if ($PSCmdlet.ParameterSetName -eq "byID") {
            $uri = $uri.Replace('{release_id}', $ReleaseID.ToString())
            Write-Verbose -Message "Release ID: $ReleaseID"
        } elseif ($PSCmdlet.ParameterSetName -eq "ByStub") {
            $uri = $uri.Replace('{release_id}', $FromReleaseStub.Id.ToString())
            Write-Verbose -Message "Release ID: $($FromReleaseStub.Id)"
        } else {
            throw "No Artist Specified Please specify via '-ReleaseID' or '-FromReleaseStub'."
        }

        $URIargs += Add-URIArgument -Key 'token' -Value $token.trim()

        if ([string]::IsNullOrWhiteSpace($FromReleaseStub)) {
            $URIargs += Add-URIArgument -Key 'curr_abbr' -Value $CurrencyAbbrv.trim()
        }

        $URI = Convert-URIArguments -URI $URI -URIArgs $URIargs
    }

    process {
        try {
            $resp = Invoke-WebRequest -Uri $URI -UseBasicParsing -Method GET
        } catch {
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
        return $resp.Content | ConvertFrom-Json
    }
}