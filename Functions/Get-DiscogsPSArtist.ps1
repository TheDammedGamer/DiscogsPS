#API Pattern
#https://api.discogs.com/artists/{artist_id}

#region begin Dev
# Load Helper Fucntions
. .\HelperFunctions\Convert-URIArguments.ps1
. .\HelperFunctions\Add-URIArguments.ps1
# Load Objects
. .\Objects\DiscogsArtist.ps1
#endregion Dev

function Get-DiscogsPSArtist {
    [CmdletBinding()]
    [OutputType([DiscogsArtist])]
    param (
        [Parameter(Position=0, Mandatory=$false)]
        [int] $ArtistID,

        [Parameter(Position=1, Mandatory=$false)]
        [string] $Token,

        [Parameter(Position=0, Mandatory=$false, ValueFromPipeline=$true)]
        [DiscogsArtistMember] $FromArtistMember
    )

    begin {
        $URIargs = @()
        $uri = 'https://api.discogs.com/artists/{artist_id}'
        if ($ArtistID -ne $null) {
            $uri = $uri.Replace('{artist_id}', $ArtistID.ToString())
            Write-Verbose -Message "Artist ID: $ArtistID"
        } elseif ($FromArtistMember -ne $null) {
            $uri = $uri.Replace('{artist_id}', $FromArtist.ID.ToString())
            $temp = $FromArtist.ID
            Write-Verbose -Message "Artist ID: $temp"
        } else {
            throw "No Artist Specified Please specify via '-ArtistID' specifiying a valid artist id number or '-FromArtistMember' Specifying an DiscogsArtistMember Object"
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
            if (($resp.StatusCode -eq 404) -and ($($resp.Content | ConvertFrom-Json).message -eq 'Artist not found.' )) {
                throw "Artist not found on Discogs."
            } elseif ($resp.StatusCode -eq 404) {
                throw "Error 404 from Discogs API Check Connection to https://api.discogs.com"
            } else {
                throw $_
            }
        }
    }

    end {
        return [DiscogsArtist]::new($resp.Content)
    }
}