#API Pattern
#https://api.discogs.com/artists/{artist_id}/releases{?sort,sort_order}

function Get-DiscogsPSArtistReleases {
    [CmdletBinding()]
    [OutputType([HashTable])]
    param (
        # Use Artist ID
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "byID")] [Alias("Id")]
        [int] $ArtistId,

        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = "byArtist")]
        [DiscogsPS.Lib.Artist] $FromArtist,

        [Parameter(Mandatory = $true, ParameterSetName = "byArtist")]
        [Parameter(Mandatory = $false, ParameterSetName = "byID")]
        [string] $Token,

        [Parameter(Mandatory = $false, ParameterSetName = "byArtist")]
        [Parameter(Mandatory = $false, ParameterSetName = "byID")]
        [ValidateSet("year", "title", "format")]
        [string] $SortBy,

        [Parameter(Mandatory = $false, ParameterSetName = "byArtist")]
        [Parameter(Mandatory = $false, ParameterSetName = "byID")]
        [ValidateSet("asc", "desc")]
        [string] $SortOrder
    )

    begin {
        $URIargs = @()

        $uri = 'https://api.discogs.com/artists/{artist_id}/releases'
        if ($PSCmdlet.ParameterSetName -eq "byID") {
            $uri = $uri.Replace('{artist_id}', $ArtistID.ToString())
            Write-Verbose -Message "Artist ID: $ArtistID"
        } elseif ($PSCmdlet.ParameterSetName -eq "byArtist") {
            $uri = $uri.Replace('{artist_id}', $FromArtist.Id.ToString())
            Write-Verbose -Message "Artist ID: $($FromArtist.Id)"
        } else {
            throw "No Artist Specified Please specify via '-ArtistID' or '-FromArtist'."
        }

        $URIargs += Add-URIArgument -Key 'token' -Value $token.trim()

        if ([string]::IsNullOrWhiteSpace($SortBy)) {
            $URIargs += Add-URIArgument -Key 'sort' -Value $SortBy.trim()
        }
        if ([string]::IsNullOrWhiteSpace($SortOrder.trim())) {
            $URIargs += Add-URIArgument -Key 'sort_order' -Value $SortOrder.trim()
        }

        # return 100 items per request
        $URIargs += Add-URIArgument -Key 'per_page' -Value '100'
        # Ensure we are at Page 1
        $URIargs += Add-URIArgument -Key 'page' -Value '1'

        $URI = Convert-URIArguments -URI $URI -URIArgs $URIargs

        $ErrorList = [System.Collections.Generic.List[DiscogsPS.Lib.APIError]]::new()
        $ErrorList.Add([DiscogsPS.Lib.APIError]::SimpleError(404, "Error 404 from Discogs API Check Connection to https://api.discogs.com"))
        $ErrorList.Add([DiscogsPS.Lib.APIError]::ComplexError(404, "Artist not found on Discogs", "Artist not found."))

    }

    process {
        $ObjectsOut = Invoke-DiscogsPaging -IntialURI $URI -PossibleErrors $ErrorList
    }

    end {
        return $ObjectsOut
    }
}