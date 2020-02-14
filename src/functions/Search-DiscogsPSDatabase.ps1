#Database Search URL Pattern
#https://api.discogs.com/database/search?q={query}&{?type,title,release_title,credit,artist,anv,label,genre,style,country,year,format,catno,barcode,track,submitter,contributor}


function Search-DiscogsPSDatabase {
    [CmdletBinding()]
    [OutputType([HashTable])]
    param (
        # Parameter help description
        [Parameter(Position=0, Mandatory=$true)][string]$Query,
        [Parameter(Position=1, Mandatory=$true)][string]$Token
    )

    begin {
        $URIargs = @()

        $URIBase = 'https://api.discogs.com/database/search'

        $URIargs += Add-URIArgument -Key 'query' -Value $Query
        $URIargs += Add-URIArgument -Key 'token' -Value $tokens

        # PAgination Params
        $URIargs += Add-URIArgument -Key 'per_page' -Value '100'
        $URIargs += Add-URIArgument -Key 'page' -Value '1'

        $URI = Convert-URIArguments -URI $URIBase -URIArgs $URIargs
    }

    process {

        try {
            $resp = Invoke-WebRequest -Uri $URI -UseBasicParsing -Method GET
        }
        catch {
            if ($resp.StatusCode -eq 404) {
                throw "Error 404 from Discogs API Check Connection to https://api.discogs.com"
            } elseif ($resp.StatusCode -eq 404) {
                # 500 relates to internal server errors
                $jsonres =  $resp.Content | ConvertFrom-Json
                if ($jsonres.message -eq 'Query time exceeded. Please try a simpler query.') {
                    throw 'Query timeout. Please try a simpler query.'
                } elseif ($jsonres.message -eq 'An internal server error occurred. (Malformed query?)') {
                    throw 'Internal Server Error. Possible malformed query.'
                } else {
                    throw $_
                }
            } else {
                throw $_
            }
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
            Write-Verbose -Message "Total items Left To Get, $totalItemsToGet From $totalPages Pages"
            Write-Verbose -Message "Pages left to Get: $leftToGet"

            # Stats the Resuls of the first Page
            $ObjectsOut += $resp.Content | ConvertFrom-Json | Select-Object -ExpandProperty results

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
                $ObjectsOut += $PageResp.Content | ConvertFrom-Json | Select-Object -ExpandProperty results
                # Wait for a Second to ensure we don't get Ratelimited
                Start-Sleep -Seconds 1
            }
        } else {
            # we don't have to use paging content
            # Grab the FirstPage release and add them to the Array Out object
            $ObjectsOut += $resp.Content | ConvertFrom-Json | Select-Object -ExpandProperty releases
        }
    }

    end {
        $out = $ObjectsOut
        return $out
    }
}
function Search-DiscogsPSDatabaseAdvanced {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(Position=0, Mandatory=$false)][string]$Query
    )

    begin {
    }

    process {
    }

    end {
    }
}