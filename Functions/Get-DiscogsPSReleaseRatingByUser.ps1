#API Pattern
#https://api.discogs.com/releases/{release_id}/rating/{username}

# Develoment Only
# Load Helper Functions
#. .\HelperFunctions\Convert-URIArguments.ps1
#. .\HelperFunctions\Add-URIArguments.ps1

function Get-DiscogsPSReleaseRatingByUser {
    [CmdletBinding()]
    [OutputType([HashTable])]
    param (
        # Use Artist ID
        [Parameter(Position=0, Mandatory=$true)][int]$ReleaseID,
        [Parameter(Position=1, Mandatory=$true)][string]$DiscogsUsername,
        [Parameter(Position=2, Mandatory=$false)][string]$Token
    )

    begin {
        $URIargs = @()

        $URI = 'https://api.discogs.com/releases/{release_id}/rating/{username}'

        if ($ReleaseID -ne $null) {
            $URI = $URI.Replace('{release_id}', $ReleaseID.ToString())
            Write-Verbose -Message "Release ID: $ReleaseID"
        } else {
            throw "No Release ID specified, please specify via '-ReleaseID' specifiying a valid release id."
        }

        if ($DiscogsUsername -ne '') {
            $URI = $URI.Replace('{username}', $DiscogsUsername.ToString())
            Write-Verbose -Message "Discogs Username: $DiscogsUsername"
        } else {
            throw "No Discogs Username specified, please specify via '-DiscogsUsername' specifiying a valid Discogs Username."
        }

        if ($token.trim() -ne '') {
            $URIargs += Add-URIArgument -Key 'token' -Value $token.trim()
        }

        $URI = Convert-URIArguments -URI $URI -URIArgs $URIargs
    }

    process {
        try {
            $resp = Invoke-WebRequest -Uri $URI -UseBasicParsing -Method GET
        }
        catch {
            if ($resp.StatusCode -eq 404) {
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