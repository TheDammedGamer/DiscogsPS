#API Pattern
#https://api.discogs.com/artists/{artist_id}

function Get-DiscogsPSArtist {
    [CmdletBinding()]
    [OutputType([DiscogsArtist])]
    param (
        [Parameter(Position = 0, ValueFromPipeline = $true, ParameterSetName = "byID")] [Alias("Id")]
        [int] $ArtistId,

        [Parameter(Position = 0, ValueFromPipeline = $true, ParameterSetName = "ByMember")]
        [DiscogsPS.Lib.ArtistMember] $FromArtistMember,

        [Parameter(Position = 0, ValueFromPipeline = $true, ParameterSetName = "ByRef")]
        [DiscogsPS.Lib.ArtistMember] $FromArtistRef,

        [Parameter(Position = 1, Mandatory = $true, ParameterSetName = "byID")]
        [Parameter(Position = 1, Mandatory = $true, ParameterSetName = "ByMember")]
        [Parameter(Position = 1, Mandatory = $true, ParameterSetName = "ByRef")]
        [string] $Token
    )

    begin {
        $URIargs = @()
        $URI = 'https://api.discogs.com/artists/{artist_id}'


        if ($PSCmdlet.ParameterSetName -eq "byID") {
            $URI = $URI.Replace('{artist_id}', $ArtistId.ToString())
            Write-Verbose -Message "Artist ID: $ArtistId"
        } elseif ($PSCmdlet.ParameterSetName -eq "ByMember") {
            $URI = $URI.Replace('{artist_id}', $FromArtistMember.Id.ToString())
            Write-Verbose -Message "Artist ID: $($FromArtistMember.Id)"
        } elseif ($PSCmdlet.ParameterSetName -eq "ByRef") {
            $URI = $URI.Replace('{artist_id}', $FromArtistRef.Id.ToString())
            Write-Verbose -Message "Artist ID: $($FromArtistRef.Id)"
        } else {
            throw "No Artist Specified Please specify via '-ArtistID' or '-FromArtistMember' or '-FromArtistRef'."
        }
        $URIargs += Add-URIArgument -Key 'token' -Value $token.trim()

        $URI = Convert-URIArguments -URI $URI -URIArgs $URIargs
    }

    process {
        try {
            $resp = Invoke-WebRequest -Uri $URI -UseBasicParsing -Method GET -ErrorAction Stop
        } catch {
            if (($resp.StatusCode -eq 404) -and ($($resp.Content | ConvertFrom-Json).message -eq 'Artist not found.' )) {
                throw "Artist Id not found on Discogs."
            } elseif ($resp.StatusCode -eq 404) {
                throw "Error 404 from Discogs API Check Connection to https://api.discogs.com"
            } else {
                throw $_
            }
        }
    }

    end {
        return [DiscogsPS.Lib.Artist]::Create($resp.Content)
    }
}