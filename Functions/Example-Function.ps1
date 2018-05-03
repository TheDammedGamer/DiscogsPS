# API Format:
# https://api.discogs.com/

# Load Helper Fucntions
. $PSScriptRoot\HelperFunctions\Convert-URIArguments.ps1
. $PSScriptRoot\HelperFunctions\Add-URIArgouments.ps1

function Get-DiscogsPSSomething {
    [CmdletBinding()]
    param (
        [Parameter( Position=0, Mandatory=$true,  HelpMessage='Enter a valid something id number.' )] [alias("ID")] [int]$SomethingID,

        [Parameter(Position=1, Mandatory=$false, HelpMessage='Enter a valid User token from Discogs.')][string]$Token
    )

    begin {
        $URIargs = @()

        $uri = 'https://api.discogs.com/'
        if ($SomethingID -ne $null) {
            $uri = $uri.Replace('{something_id}', $SomethingID.ToString())
            Write-Verbose -Message "something ID: $SomethingID"
        } else {
            throw "No something ID Specified Please specify via '-somethingID' specifiying a valid something ID"
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
            throw $_
        }
    }

    end {
        return $resp.Content | ConvertFrom-Josn
    }
}