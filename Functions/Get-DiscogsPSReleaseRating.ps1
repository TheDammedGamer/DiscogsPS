#API Pattern
#https://api.discogs.com/releases/{release_id}/rating

# Develoment Only
# Load Helper Fucntions
. .\HelperFunctions\Convert-URIArguments.ps1
. .\HelperFunctions\Add-URIArguments.ps1

function Get-DiscogsPSReleaseRating {
    [CmdletBinding()]
    [OutputType([HashTable])]
    param (
        # Use Artist ID
        [Parameter(Position=0, Mandatory=$true)][int]$ReleaseID,
        [Parameter(Position=1, Mandatory=$false)][string]$Token#,
        #[Parameter(Position=0, Mandatory=$false, ValueFromPipeline=$true)][DiscogsRelease]$FromRelease
    )

    begin {
        $URIargs = @()

        $uri = 'https://api.discogs.com/releases/{release_id}/rating'

        if ($ReleaseID -ne $null) {
            $uri = $uri.Replace('{release_id}', $ReleaseID.ToString())
            Write-Verbose -Message "Release ID: $ReleaseID"
        } else {
            throw "No Release ID specified, please specify via '-ReleaseID' specifiying a valid release id."
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