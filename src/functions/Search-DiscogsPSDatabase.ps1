#Database Search URL Pattern
#https://api.discogs.com/database/search?q={query}&{?type,title,release_title,credit,artist,anv,label,genre,style,country,year,format,catno,barcode,track,submitter,contributor}


function Search-DiscogsPSDatabase {
    [CmdletBinding()]
    [OutputType([HashTable])]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "Simple", HelpMessage = "Your search query")]
        [string]$SimpleQuery,

        [Parameter(Mandatory = $false, ParameterSetName = "Complex", HelpMessage = "Your search query")]
        [string]$Query,

        [Parameter(Mandatory = $true, ParameterSetName = "Simple")]
        [Parameter(Mandatory = $true, ParameterSetName = "Complex")]
        [string]$Token,

        [Parameter(Mandatory = $false, ParameterSetName = "Complex", HelpMessage = "Filter by result type.")]
        [ValidateSet("release", "master", "artist", "label")]
        [string]$Type, # 'type'
        [Parameter(Mandatory = $false, ParameterSetName = "Complex", HelpMessage = "Search by combined 'Artist Name - Release Title' title field.")]
        [string]$Title, # 'title'
        [Parameter(Mandatory = $false, ParameterSetName = "Complex", HelpMessage = "Search release titles.")]
        [string]$ReleaseTitle, # 'release_title'
        [Parameter(Mandatory = $false, ParameterSetName = "Complex", HelpMessage = "Search release credits.")]
        [string]$Credit, # 'credit'
        [Parameter(Mandatory = $false, ParameterSetName = "Complex", HelpMessage = "Search artist names.")]
        [string]$Artist, # 'artist'
        [Parameter(Mandatory = $false, ParameterSetName = "Complex", HelpMessage = "Search artist ANV.")]
        [string]$ANV, # 'anv'
        [Parameter(Mandatory = $false, ParameterSetName = "Complex", HelpMessage = "Search label names.")]
        [string]$Label, # 'label'
        [Parameter(Mandatory = $false, ParameterSetName = "Complex", HelpMessage = "Search genres.")]
        [string]$Genre, # 'genre'
        [Parameter(Mandatory = $false, ParameterSetName = "Complex", HelpMessage = "Search styles.")]
        [string]$Style, # 'style'
        [Parameter(Mandatory = $false, ParameterSetName = "Complex", HelpMessage = "Search release country.")]
        [string]$Country, # 'country'
        [Parameter(Mandatory = $false, ParameterSetName = "Complex", HelpMessage = "Search release year.")]
        [int]$Year, # 'year'
        [Parameter(Mandatory = $false, ParameterSetName = "Complex", HelpMessage = "Search formats.")]
        [string]$Format, # 'format'
        [Parameter(Mandatory = $false, ParameterSetName = "Complex", HelpMessage = "Search catalog number.")]
        [string]$CatalogNo, # 'catno'
        [Parameter(Mandatory = $false, ParameterSetName = "Complex", HelpMessage = "Search barcodes.")]
        [string]$Barcode, # 'barcode'
        [Parameter(Mandatory = $false, ParameterSetName = "Complex", HelpMessage = "Search track titles.")]
        [string]$Track, # 'track'
        [Parameter(Mandatory = $false, ParameterSetName = "Complex", HelpMessage = "Search submitter username.")]
        [string]$Submitter, # 'submitter'
        [Parameter(Mandatory = $false, ParameterSetName = "Complex", HelpMessage = "Search contributor usernames.")]
        [string]$Contributor # 'contributor'

    )

    begin {
        $URIargs = @()

        $URIBase = 'https://api.discogs.com/database/search'

        if ($PSCmdlet.ParameterSetName -eq "Simple") {
            $URIargs += Add-URIArgument -Key 'query' -Value $SimpleQuery
            $URIargs += Add-URIArgument -Key 'token' -Value $Token
        } elseif ($PSCmdlet.ParameterSetName -eq "Complex") {
            if ($PSBoundParameters.Keys.Count -lt 2) {
                Write-Error -Message "Unable to search without a user Token and another parameter."
            }
            $PSBoundParameters.Keys | ForEach-Object {
                switch ($_) {
                    'Query' {
                        $URIargs += Add-URIArgument -Key 'query' -Value $query
                    }
                    'Token' {
                        $URIargs += Add-URIArgument -Key 'token' -Value $Token
                    }
                    'Type' {
                        $URIargs += Add-URIArgument -Key 'type' -Value $Type
                    }
                    'Title' {
                        $URIargs += Add-URIArgument -Key 'title' -Value $Title
                    }
                    'ReleaseTitle' {
                        $URIargs += Add-URIArgument -Key 'release_title' -Value $ReleaseTitle
                    }
                    'Credit' {
                        $URIargs += Add-URIArgument -Key 'credit' -Value $Credit
                    }
                    'Artist' {
                        $URIargs += Add-URIArgument -Key 'artist' -Value $Artist
                    }
                    'ANV' {
                        $URIargs += Add-URIArgument -Key 'anv' -Value $ANV
                    }
                    'Label' {
                        $URIargs += Add-URIArgument -Key 'label' -Value $Label
                    }
                    'Genre' {
                        $URIargs += Add-URIArgument -Key 'genre' -Value $Genre
                    }
                    'Style' {
                        $URIargs += Add-URIArgument -Key 'style' -Value $Style
                    }
                    'Country' {
                        $URIargs += Add-URIArgument -Key 'country' -Value $Country
                    }
                    'Year' {
                        $URIargs += Add-URIArgument -Key 'year' -Value $Year
                    }
                    'Format' {
                        $URIargs += Add-URIArgument -Key 'format' -Value $Format
                    }
                    'CatalogNo' {
                        $URIargs += Add-URIArgument -Key 'catno' -Value $CatalogNo
                    }
                    'Barcode' {
                        $URIargs += Add-URIArgument -Key 'barcode' -Value $Barcode
                    }
                    'Track' {
                        $URIargs += Add-URIArgument -Key 'track' -Value $Track
                    }
                    'Submitter' {
                        $URIargs += Add-URIArgument -Key 'submitter' -Value $Submitter
                    }
                    'Contributor' {
                        $URIargs += Add-URIArgument -Key 'contributor' -Value $Contributor
                    }
                }
            }
        }

        # Pagination Params
        $URIargs += Add-URIArgument -Key 'per_page' -Value '100'
        $URIargs += Add-URIArgument -Key 'page' -Value '1'

        $URI = Convert-URIArguments -URI $URIBase -URIArgs $URIargs
    }

    process {
        $ErrorList = [System.Collections.Generic.List[DiscogsPS.Lib.APIError]]::new()
        $ErrorList.Add([DiscogsPS.Lib.APIError]::SimpleError(404, "Error 404 from Discogs API Check Connection to https://api.discogs.com"))
        $ErrorList.Add([DiscogsPS.Lib.APIError]::ComplexError(500, "Query Timeout. Please try again with a simpler query.", "Query time exceeded. Please try a simpler query."))
        $ErrorList.Add([DiscogsPS.Lib.APIError]::ComplexError(500, "Internal Server Error, Psosible Malformed Query.", "An internal server error occurred. (Malformed query?)"))

        $ObjectsOut = Invoke-DiscogsPaging -IntialURI $URI -PossibleErrors $ErrorList
    }

    end {
        return $ObjectsOut
    }
}