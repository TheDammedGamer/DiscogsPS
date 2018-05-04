# API Format:
# https://api.discogs.com/labels/{label_id}/releases{?page,per_page}

# Develoment Only
# Load Helper Fucntions
. .\HelperFunctions\Convert-URIArguments.ps1
. .\HelperFunctions\Add-URIArguments.ps1

#Load Needed Objects
. .\Objects\DiscogsPaging.ps1

function Get-DiscogsPSLabelReleases {
    [CmdletBinding()]
    [OutputType([HashTable[]])]
    param (
        [Parameter(Position=0, Mandatory=$true, HelpMessage='Enter a valid Label id number.')] [alias("ID")] [int]$LabelID,

        [Parameter(Position=1, Mandatory=$false, HelpMessage='Enter a valid User token from Discogs.')][string]$Token
    )

    begin {
        $URIargs = @()

        $uri = 'https://api.discogs.com/labels/{label_id}/releases'
        if ($LabelID -ne $null) {
            $uri = $uri.Replace('{label_id}', $LabelID.ToString())
            Write-Verbose -Message "Label ID: $LabelID"
        } else {
            throw "No Label ID Specified Please specify via '-LabelID' specifiying a valid Label ID"
        }

        if ($token.trim() -ne '') {
            $URIargs += Add-URIArgument -Key 'token' -Value $token.trim()
        }
        #return 100 items per request
        $URIargs += Add-URIArgument -Key 'per_page' -Value '100'
        #Ensure we are at Page 1
        $URIargs += Add-URIArgument -Key 'page' -Value '1'

        $URI = Convert-URIArguments -URI $URI -URIArgs $URIargs
    }

    process {
        # Initial Request for Page 1
        try {
            Write-Verbose -Message "Getting Page: 1"
            $resp = Invoke-WebRequest -Uri $URI -UseBasicParsing -Method GET
        }
        catch {
            # Thow Error
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
            Write-Verbose -Message "Total items Left To Get, $totalItemsToGet From $totalPages Pages"
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
        return $ObjectsOut
    }
}