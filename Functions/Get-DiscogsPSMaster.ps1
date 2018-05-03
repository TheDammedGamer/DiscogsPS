#API Pattern
#https://api.discogs.com/masters/{master_id}


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


        if ($token.trim() -ne $null) {
            $argument = 'token=' + $token.trim()
            $URIargs += $argument
            Write-Verbose -Message "Adding URL argument: $argument"
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
        return $resp.Content | ConvertFrom-Josn
    }
}