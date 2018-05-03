#API Pattern
#https://api.discogs.com/releases/{release_id}/rating/{username}

# Load Helper Fucntions
. $PSScriptRoot\HelperFunctions\Convert-URIArguments.ps1
. $PSScriptRoot\HelperFunctions\Add-URIArgouments.ps1

function Get-DiscogsPSReleaseRatingByUser {
    [CmdletBinding()]
    param (
        # Use Artist ID
        [Parameter(Position=0, Mandatory=$true)][int]$ReleaseID,
        [Parameter(Position=1, Mandatory=$true)][string]$DiscogsUsername,
        [Parameter(Position=2, Mandatory=$false)][string]$Token
    )

    begin {
        $URIargs = @()

        $uri = 'https://api.discogs.com/releases/{release_id}/rating/{username}'

        if ($ReleaseID -ne $null) {
            $uri = $uri.Replace('{release_id}', $ReleaseID.ToString())
            Write-Verbose -Message "Release ID: $ReleaseID"
        } else {
            throw "No Release ID specified, please specify via '-ReleaseID' specifiying a valid release id."
        }

        if ($DiscogsUsername -ne '') {
            $uri = $uri.Replace('{username}', $DiscogsUsername.ToString())
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
            $resp = Invoke-WebRequest -Uri $uri -UseBasicParsing -Method GET
        }
        catch {
            #Thow Error
            #TODO: Add Error handeling for each response as per the API Docs
            throw $_
        }
    }

    end {
        #return [DiscogsArtist]::new($resp.Content)
        return $resp.Content | ConvertFrom-Json
    }
}