# API Format:
# /labels/{label_id}

# Develoment Only
# Load Helper Fucntions
. .\HelperFunctions\Convert-URIArguments.ps1
. .\HelperFunctions\Add-URIArguments.ps1


function Get-DiscogsPSMaster {
    [CmdletBinding()]
    [OutputType([HashTable])]
    param (
        # Use Artist ID
        [Parameter( Position=0, Mandatory=$true,  HelpMessage='Enter a valid label id number.' )]
        [alias("ID")]
        [int]$LabelID,

        [Parameter(Position=1, Mandatory=$false, HelpMessage='Enter a valid User token from Discogs.')][string]$Token
    )

    begin {
        $URIargs = @()

        $uri = 'https://api.discogs.com/labels/{label_id}'
        if ($LabelID -ne $null) {
            $uri = $uri.Replace('{label_id}', $LabelID.ToString())
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
        return $resp.Content | ConvertFrom-Josn
    }
}