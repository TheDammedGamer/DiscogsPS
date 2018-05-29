# Develoment Only
# Load Helper Fucntions
. .\HelperFunctions\Convert-URIArguments.ps1
. .\HelperFunctions\Add-URIArguments.ps1

#Load Needed Objects
. .\Objects\DiscogsPaging.ps1



#-UserAgent 'DiscogsPS/1.0 +http://github.com/thedammedgamer'

class DiscogsError {
    [int]$StatusCode
    [string]$Message
    [bool]$IsSimple
    DiscogsError([int]$code, [string]$msg, [bool]$simpleError){
        $this.StatusCode = $code
        $this.Message = $msg
        $this.IsSimple = $simpleError
    }
    DiscogsError([int]$code, [string]$msg){
        $this.StatusCode = $code
        $this.Message = $msg
        $this.IsSimple = $false
    }
}

$errors = @()
$errors += New-Object -TypeName 'DiscogsError' -ArgumentList @(404, "Error 404 from Discogs API Check Connection to https://api.discogs.com", $true)
$errors += New-Object -TypeName 'DiscogsError' -ArgumentList @(500, "Query time exceeded. Please try a simpler query.", $false)
$errors += New-Object -TypeName 'DiscogsError' -ArgumentList @(500, "An internal server error occurred. (Malformed query?)", $false)

$errors | Where-Object {$_.IsSimple -eq $false} | ForEach-Object {
    $Current = $_
    if (($httpcode -eq $Current.StatusCode) -and ($msg -eq $Current.Message)) {
        throw $Current.Message
    }
}

$errors | Where-Object {$_.IsSimple -eq $true} | ForEach-Object {
    $Current = $_
    if ($httpcode -eq $Current.StatusCode) {
        throw $Current.Message
    }
}

function Invoke-DiscogsPSPaging {
    [CmdletBinding()]
    [OutputType([HashTable])]
    param (
        # Parameter help description
        [Parameter(Position=0, Mandatory=$true)][string]$BaseURI,
        [Parameter(Position=1, Mandatory=$false)][DiscogsError[]]$Errors
    )

    try {
        $resp = Invoke-WebRequest -Uri $uri -UseBasicParsing -Method GET -UserAgent 'DiscogsPS/1.0 +http://github.com/thedammedgamer'
    }
    catch {
        if ($resp.StatusCode -eq 404) {
            throw "Error 404 from Discogs API Check Connection to https://api.discogs.com"
        } elseif ($resp.StatusCode -eq 500) {
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
                $PageResp = Invoke-WebRequest -Uri $nextURI -UseBasicParsing -Method GET -UserAgent 'DiscogsPS/1.0 +http://github.com/thedammedgamer'
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