#API Pattern
#https://api.discogs.com/artists/{artist_id}/releases{?sort,sort_order}

#TODO: Implement Pagination

#Include the relevant Objects
#. $PSScriptRoot\Objects\DiscogsArtist.ps1


function Get-DiscogsPSArtistReleases {
    [CmdletBinding()]
    param (
        # Use Artist ID
        [Parameter(Position=0, Mandatory=$false)][int]$ArtistID,
        [Parameter(Position=0, Mandatory=$false, ValueFromPipeline=$true)][DiscogsArtist]$FromArtist,
        [Parameter(Position=1, Mandatory=$false)][string]$Token,
        [Parameter(Mandatory=$false)][string]$Sort,
        [Parameter(Mandatory=$false)][string]$SortOrder
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


        if ($token.trim() -ne $null) {
            $argument = 'token=' + $token.trim()
            $URIargs += $argument
            Write-Verbose -Message "Adding URL argument: $argument"
        }

        if ($sort.trim().Length -gt 0) {
            switch ($sort.trim().ToLower()) {
                'year' {
                    $argument = 'sort=year'
                    $URIargs += $argument
                    Write-Verbose -Message "Adding URL argument: $argument"
                }
                'title' {
                    $argument = 'sort=title'
                    $URIargs += $argument
                    Write-Verbose -Message "Adding URL argument: $argument"
                }
                'format' {
                    $argument = 'sort=format'
                    $URIargs += $argument
                    Write-Verbose -Message "Adding URL aregument: $argument"
                }
                Default {
                    throw "Sort is an incorrect value, the avaliable values are: 'year', 'title' and 'format'. You Specified: $sort"
                }
            }
        }

        if ($SortOrder.trim().Length -gt 0) {
            switch ($SortOrder.trim().ToLower()) {
                'asc' {
                    $argument = 'sort_order=asc'
                    $URIargs += $argument
                    Write-Verbose -Message "Adding URL argument: $argument"
                }
                'desc' {
                    $argument = 'sort_order=desc'
                    $URIargs += $argument
                    Write-Verbose -Message "Adding URL argument: $argument"
                }
                Default {
                    throw "Sort is an incorrect value, the avaliable values are: 'asc' and 'desc'. You Specified: $sort"
                }
            }
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
        return $resp.Content
    }
}