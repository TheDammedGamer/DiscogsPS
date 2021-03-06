# API Format:
# /labels/{label_id}


#region begin Dev
# Load Helper Fucntions
. .\HelperFunctions\Convert-URIArguments.ps1
. .\HelperFunctions\Add-URIArguments.ps1
# Load Objects
. .\Objects\DiscogsArtist.ps1
#endregion Dev

function Get-DiscogsPSLabel {
    [CmdletBinding()]
    [OutputType([HashTable])]
    param (
        # Use Artist ID
        [Parameter(Position=0, Mandatory=$true, HelpMessage='Enter a valid label id number.')]
        [alias("ID")] [int] $LabelID,

        [Parameter(Position=1, Mandatory=$false, HelpMessage='Enter a valid User token from Discogs.')]
        [string] $Token
    )

    begin {
        $URIargs = @()
        $URI = 'https://api.discogs.com/labels/{label_id}'
        if ($LabelID -ne $null) {
            $URI = $URI.Replace('{label_id}', $LabelID.ToString())
            Write-Verbose -Message "Label ID: $LabelID"
        } else {
            throw "No Label ID Specified Please specify via '-MasterID' specifiying a valid Label ID"
        }
        if ($token.trim() -ne '') {
            $URIargs += Add-URIArgument -Key 'token' -Value $token.trim()
        }
        $URI = Convert-URIArguments -URI $URI -URIArgs $URIargs
    }

    process {
        try {
            $resp = Invoke-WebRequest -Uri $URI -UseBasicParsing -Method GET
        }
        catch {
            if (($resp.StatusCode -eq 404) -and ($($resp.Content | ConvertFrom-Json).message -eq 'Label not found.' )) {
                throw "Label not found on Discogs."
            } elseif ($resp.StatusCode -eq 404) {
                throw "Error 404 from Discogs API Check Connection to https://api.discogs.com"
            } else {
                throw $_
            }
        }
    }

    end {
        return $resp.Content | ConvertFrom-JSON
    }
}