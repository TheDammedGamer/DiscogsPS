#Database Search URL Pattern
#https://api.discogs.com/database/search?q={query}&{?type,title,release_title,credit,artist,anv,label,genre,style,country,year,format,catno,barcode,track,submitter,contributor}

# Develoment Only
# Load Helper Fucntions
. .\HelperFunctions\Convert-URIArguments.ps1
. .\HelperFunctions\Add-URIArguments.ps1

#Load Needed Objects
. .\Objects\DiscogsPaging.ps1
. .\Objects\DiscogsArtistMember.ps1
. .\Objects\DiscogsImage.ps1
. .\Objects\DiscogsArtist.ps1

function Search-DiscogsPSDatabase {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(Position=0, Mandatory=$true)][string]$Query,
        [Parameter(Position=1, Mandatory=$false)][string]$Token
    )

    begin {
        $URIargs = @()


        $uri = 'https://api.discogs.com/database/search'
        Write-Verbose -Message "Search URI: $uri"

        if ($Query.trim() -ne $null) {
            $QueryValue = $Query.Trim().Replace(' ','%20')
            $URIargs += Add-URIArgument -Key 'q' -Value $QueryValue
        }

        if ($token.trim() -ne $null) {
            $URIargs += Add-URIArgument -Key 'token' -Value $token.trim()
        }

        $URI = Convert-URIArguments -URI $URI -URIArgs $URIargs
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