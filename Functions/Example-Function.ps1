# API Format:
# https://api.discogs.com/

# Load Helper Fucntions
. .\HelperFunctions\Convert-URIArguments.ps1
. .\HelperFunctions\Add-URIArgouments.ps1

function Get-DiscogsPSSomething {
    [CmdletBinding()]
    param (
        [Parameter( Position=0, Mandatory=$true,  HelpMessage='Enter a valid something id number.' )] [Alias("id")] [int]$SomethingID,

        [Parameter(Position=1, Mandatory=$false, HelpMessage='Enter a valid User token from Discogs.')][string]$Token
    )

    begin {
        $URIargs = @()

        $URI = 'https://api.discogs.com/'
        if ($SomethingID -ne $null) {
            $URI = $URI.Replace('{something_id}', $SomethingID.ToString())
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
            $resp = Invoke-WebRequest -Uri $URI -UseBasicParsing -Method GET
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