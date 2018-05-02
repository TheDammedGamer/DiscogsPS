
#API Pattern
#https://api.discogs.com/artists/{artist_id}

#TODO: Implement $FromArtistMember

#Include the relevant Objects
#. $PSScriptRoot\Objects\DiscogsArtist.ps1
#. $PSScriptRoot\Objects\DiscogsArtistMember.ps1


function Get-DiscogsPSArtist {
    [CmdletBinding()]
    param (
        # Use Artist ID
        [Parameter(Position=0, Mandatory=$false)][int]$ArtistID,
        [Parameter(Position=1, Mandatory=$false)][string]$Token,
        [Parameter(Position=0, Mandatory=$false, ValueFromPipeline=$true)][DiscogsArtistMember]$FromArtistMember
    )

    begin {
        $URIargs = @()

        $uri = 'https://api.discogs.com/artists/{artist_id}'
        if ($ArtistID -ne $null) {
            $uri = $uri.Replace('{artist_id}', $ArtistID.ToString())
            Write-Verbose -Message "Artist URI: $uri"
        } elseif ($FromArtistMember -ne $null) {
            $uri = $uri.Replace('{artist_id}', $FromArtist.ID.ToString())
            Write-Verbose -Message "Artist URI: $uri"
        } else {
            throw "No Artist Specified Please specify via '-ArtistID' specifiying a valid artist id number or '-FromArtistMember' Specifying an DiscogsArtistMember Object"
        }


        if ($token.trim() -ne $null) {
            $argument = 'token=' + $token.trim()
            $URIargs += $argument
            Write-Verbose -Message "Adding URI argument: $argument"
        }

        if ($URIargs.Count -ge 1) {
            $StringToAppend = ''
            for ($i = 0; $i -lt $URIargs.Count; $i++) {
                if ($i -eq 0) {
                    #First Loop
                    $StringToAppend = $StringToAppend + '?' + $URIargs[$i]
                } else {
                    #Normal loop
                    $StringToAppend = $StringToAppend + '?' + $URIargs[$i]
                }
            }

            $uri = $uri + $StringToAppend
            Write-Verbose -Message "URL Arguments: $StringToAppend"

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
        return [DiscogsArtist]::new($resp.Content)
    }
}