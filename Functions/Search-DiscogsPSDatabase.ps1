#Database Search URL Pattern
#https://api.discogs.com/database/search?q={query}&{?type,title,release_title,credit,artist,anv,label,genre,style,country,year,format,catno,barcode,track,submitter,contributor}

#TODO: Check For Pagination and Get All Pages

function Search-DiscogsPSDatabase {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(Position=0, Mandatory=$false)][string]$Query,
        [Parameter(Position=1, Mandatory=$false)][string]$Token
    )

    begin {
        $qstring = $Query.Trim().Replace(' ','%20')
        $uri = 'https://api.discogs.com/database/search?q=' + $qstring
        Write-Verbose -Message "Search URI: $uri"

        if ($token.trim() -ne $null)
        {
            $uri = $uri + '&token=' + $token.trim()
            Write-Verbose -Message "URI with token: $uri"
        }
    }

    process {

        try {
            $resp = Invoke-WebRequest -Uri $uri -UseBasicParsing -Method GET
        }
        catch {
            #Thow Error
            #TODO: Add Error handeling for each response as per the API Docs
            throw $_
            #
        }
    }

    end {
        $out = $resp.Content | ConvertFrom-Json
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