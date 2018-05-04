#API Pattern
#https://api.discogs.com/artists/{artist_id}/releases{?sort,sort_order}

# Include the relevant Objects

# Develoment Only
# Load Helper Fucntions
. .\HelperFunctions\Convert-URIArguments.ps1
. .\HelperFunctions\Add-URIArguments.ps1

#Load Needed Objects
. .\Objects\DiscogsPaging.ps1
. .\Objects\DiscogsArtistMember.ps1
. .\Objects\DiscogsImage.ps1
. .\Objects\DiscogsArtist.ps1


function Get-DiscogsPSArtistReleases {
    [CmdletBinding()]
    [OutputType([HashTable])]
    param (
        # Use Artist ID
        [Parameter(Position=0, Mandatory=$false)][alias("ID")][int]$ArtistID,
        [Parameter(Position=0, Mandatory=$false, ValueFromPipeline=$true)][DiscogsArtist]$FromArtist,
        [Parameter(Mandatory=$false)][string]$Token,
        [Parameter(Mandatory=$false)][ValidateSet("year", "title", "format")][string]$SortBy,
        [Parameter(Mandatory=$false)][ValidateSet("asc", "desc")][string]$SortOrder
    )

    begin {
        $URIargs = @()

        $uri = 'https://api.discogs.com/artists/{artist_id}/releases'
        if ($ArtistID -ne $null) {
            $uri = $uri.Replace('{artist_id}', $ArtistID.ToString())
            Write-Verbose -Message "Artist ID: $ArtistID"
        } elseif ($FromArtist -ne $null) {
            $uri = $uri.Replace('{artist_id}', $FromArtist.id.ToString())
            $temp = $FromArtist.id
            Write-Verbose -Message "Artist ID: $temp"
        } else {
            throw "No Artist Specified Please specify via '-ArtistID' specifiying a valid artist id number or '-FromArtist' Specifying an DiscogsArtist Object"
        }


        if ($token.trim() -ne '') {
            $URIargs += Add-URIArgument -Key 'token' -Value $token.trim()
        }
        if ($SortBy.trim() -ne '') {
            $URIargs += Add-URIArgument -Key 'sort' -Value $SortBy.trim()
        }
        if ($SortOrder.trim() -ne '') {
            $URIargs += Add-URIArgument -Key 'sort_order' -Value $SortOrder.trim()
        }

        #return 100 items per request
        $URIargs += Add-URIArgument -Key 'per_page' -Value '100'
        #Ensure we are at Page 1
        $URIargs += Add-URIArgument -Key 'page' -Value '1'

        $URI = Convert-URIArguments -URI $URI -URIArgs $URIargs
    }

    process {
        try {
            Write-Verbose -Message "Getting Page: 1"
            $resp = Invoke-WebRequest -Uri $URI -UseBasicParsing -Method GET
        }
        catch {
            #Thow Error
            #TODO: Add Error handeling for each response as per the API Docs
            throw $_
        }

        $temp = $resp.Content | ConvertFrom-Json | Select-Object -ExpandProperty pagination | ConvertTo-Json
        [DiscogsPaging]$Paging = New-Object -TypeName DiscogsPaging -ArgumentList @($temp)

        #Array Out to Store the .releases
        $ObjectsOut = @()
        if ($Paging.TotalPages -gt 1) {
            # if we have to use paging logic
            $totalPages = $Paging.TotalPages
            $leftToGet = $totalPages - 1
            $totalItemsToGet = $Paging.ItemsTotal
            Write-Verbose -Message "Total items Left To Get: $totalItemsToGet"
            Write-Verbose -Message "Getting $totalPages Pages"
            Write-Verbose -Message "Pages left to Get: $leftToGet"

            # Stats the Resuls of the first Page
            $ObjectsOut += $resp.Content | ConvertFrom-Json | Select-Object -ExpandProperty releases

            [DiscogsPaging]$currentPage = $Paging
            for ($page = 1; $page -lt $Paging.TotalPages; $page++) {
                # Iterate through Each Page
                $actPage = $page + 1
                Write-Verbose -Message "Getting Page: $actPage"
                $nextURI = $currentPage.NextPageURL
                try {
                    $PageResp = Invoke-WebRequest -Uri $nextURI -UseBasicParsing -Method GET
                }
                catch {
                    # Thow Error
                    throw $_
                }
                $CurrPagetemp = $PageResp.Content | ConvertFrom-Json | Select-Object -ExpandProperty pagination | ConvertTo-Json
                $currentPage = New-Object -TypeName DiscogsPaging -ArgumentList @($CurrPagetemp)

                # Statsh the Results of the Current Page
                $ObjectsOut += $PageResp.Content | ConvertFrom-Json | Select-Object -ExpandProperty releases
                # Wait for a Second to ensure we don't get Ratelimited
                start-Sleep -Seconds 1
            }
        } else {
            # we don't have to use paging content
            # Grab the FirstPage release and add them to the Array Out object
            $ObjectsOut += $resp.Content | ConvertFrom-Json | Select-Object -ExpandProperty releases
        }
    }

    end {
        #return [DiscogsArtist]::new($resp.Content)
        return $ObjectsOut
    }
}