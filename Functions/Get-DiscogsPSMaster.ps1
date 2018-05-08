#API Pattern
#https://api.discogs.com/masters/{master_id}

# Develoment Only
# Load Helper Fucntions
. .\HelperFunctions\Convert-URIArguments.ps1
. .\HelperFunctions\Add-URIArguments.ps1

function Get-DiscogsPSMaster {
    [CmdletBinding()]
    param (
        # Use Artist ID
        [Parameter(
            Position=0,
            Mandatory=$true,
            HelpMessage="Enter a valid release master id number."
            )]
        [alias("ID")]
        [int]$MasterID,

        [Parameter(Position=1, Mandatory=$false, HelpMessage="Enter a valid User token from Discogs.")][string]$Token
    )

    begin {
        $URIargs = @()

        $uri = 'https://api.discogs.com/masters/{master_id}'
        if ($MasterID -ne $null) {
            $uri = $uri.Replace('{master_id}', $MasterID.ToString())
            Write-Verbose -Message "Master ID: $MasterID"
        } else {
            throw "No Master Release ID Specified Please specify via '-MasterID' specifiying a valid Master Release ID"
        }

        if ($token.trim() -ne '') {
            $URIargs += Add-URIArgument -Key 'token' -Value $token.trim()
        }

        $URI = Convert-URIArguments -URI $URI -URIArgs $URIargs
    }

    process {
        try {
            $resp = Invoke-WebRequest -Uri $uri -UseBasicParsing -Method GET
        }
        catch {
            if (($resp.StatusCode -eq 404) -and ($($resp.Content | ConvertFrom-Json).message -eq 'Master Release not found.' )) {
                throw "Master Release not found on Discogs."
            } elseif ($resp.StatusCode -eq 404) {
                throw "Error 404 from Discogs API Check Connection to https://api.discogs.com"
            } else {
                throw $_
            }
        }
    }

    end {
        #return [DiscogsArtist]::new($resp.Content)
        return $resp.Content | ConvertFrom-Json
    }
}