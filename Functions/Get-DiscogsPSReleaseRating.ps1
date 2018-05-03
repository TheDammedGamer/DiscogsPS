#API Pattern
#https://api.discogs.com/releases/{release_id}/rating


function Get-DiscogsPSReleaseRating {
    [CmdletBinding()]
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

        if ($token.trim() -ne $null) {
            $argument = 'token=' + $token.trim()
            $URIargs += $argument
            Write-Verbose -Message "Adding URL argument: $argument"
        }

        if ($URIargs.Count -ge 1) {
            $StringToAppend = ''
            for ($i = 0; $i -lt $URIargs.Count; $i++) {
                if ($i -eq 0) {
                    #First Loop
                    $StringToAppend = $StringToAppend + '?' + $URIargs[$i]
                } else {
                    #Normal loop
                    $StringToAppend = $StringToAppend + '&' + $URIargs[$i]
                }
            }
            $uri = $uri + $StringToAppend
            Write-Verbose -Message "URL Arguments: $StringToAppend"
        }
        Write-Verbose -Message "Full URL: $uri"
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