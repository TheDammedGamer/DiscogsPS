#API Pattern
#https://api.discogs.com/releases/{release_id}{?curr_abbr}

#curr_abbr
#Allowed Items = USD GBP EUR CAD AUD JPY CHF MXN BRL NZD SEK ZAR


function Get-DiscogsPSRelease {
    [CmdletBinding()]
    param (
        [Parameter(Position=0, Mandatory=$true)][int]$ReleaseID,
        [Parameter(Position=1, Mandatory=$false)][string]$Token,
        [Parameter(Mandatory=$false)][string]$CurrencyAbbrv
    )

    begin {
        $URIargs = @()

        $uri = 'https://api.discogs.com/releases/{release_id}'
        if ($ArtistID -ne $null) {
            $uri = $uri.Replace('{release_id}', $ReleaseID.ToString())
            Write-Verbose -Message "Release URI: $uri"
        } else {
            throw "No Release Specified Please specify via '-ReleaseID' specifiying a valid release id number "
        }


        if ($token.trim() -ne $null) {
            $argument = 'token=' + $token.trim()
            $URIargs += $argument
            Write-Verbose -Message "Adding URI argument: $argument"
        }

        if ($CurrencyAbbrv.trim().Length -gt 0) {
            switch ($CurrencyAbbrv.trim().ToUpper()) {
                'USD' {
                    $argument = 'curr_abbr=' + $CurrencyAbbrv.trim().ToUpper()
                    $URIargs += $argument
                    Write-Verbose -Message "Adding URI argument: $argument"
                }
                'GBP' {
                    $argument = 'curr_abbr=' + $CurrencyAbbrv.trim().ToUpper()
                    $URIargs += $argument
                    Write-Verbose -Message "Adding URI argument: $argument"
                }
                'EUR' {
                    $argument = 'curr_abbr=' + $CurrencyAbbrv.trim().ToUpper()
                    $URIargs += $argument
                    Write-Verbose -Message "Adding URI argument: $argument"
                }
                'CAD' {
                    $argument = 'curr_abbr=' + $CurrencyAbbrv.trim().ToUpper()
                    $URIargs += $argument
                    Write-Verbose -Message "Adding URI argument: $argument"
                }
                'AUD' {
                    $argument = 'curr_abbr=' + $CurrencyAbbrv.trim().ToUpper()
                    $URIargs += $argument
                    Write-Verbose -Message "Adding URI argument: $argument"
                }
                'JPY' {
                    $argument = 'curr_abbr=' + $CurrencyAbbrv.trim().ToUpper()
                    $URIargs += $argument
                    Write-Verbose -Message "Adding URI argument: $argument"
                }
                'CHF' {
                    $argument = 'curr_abbr=' + $CurrencyAbbrv.trim().ToUpper()
                    $URIargs += $argument
                    Write-Verbose -Message "Adding URI argument: $argument"
                }
                'MXN' {
                    $argument = 'curr_abbr=' + $CurrencyAbbrv.trim().ToUpper()
                    $URIargs += $argument
                    Write-Verbose -Message "Adding URI argument: $argument"
                }
                'BRL' {
                    $argument = 'curr_abbr=' + $CurrencyAbbrv.trim().ToUpper()
                    $URIargs += $argument
                    Write-Verbose -Message "Adding URI argument: $argument"
                }
                'NZD' {
                    $argument = 'curr_abbr=' + $CurrencyAbbrv.trim().ToUpper()
                    $URIargs += $argument
                    Write-Verbose -Message "Adding URI argument: $argument"
                }
                'SEK' {
                    $argument = 'curr_abbr=' + $CurrencyAbbrv.trim().ToUpper()
                    $URIargs += $argument
                    Write-Verbose -Message "Adding URI argument: $argument"
                }
                'ZAR' {
                    $argument = 'curr_abbr=' + $CurrencyAbbrv.trim().ToUpper()
                    $URIargs += $argument
                    Write-Verbose -Message "Adding URI argument: $argument"
                }
                Default {
                    throw "Currency Abreviation is an incorrect value, the avaliable values are: 'USD', 'GBP', 'EUR', 'CAD', 'AUD', 'JPY', 'CHF', 'MXN', 'BRL', 'NZD', 'SEK' and 'ZAR'. You specified: $sort"
                }
            }
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
        #return [DiscogsArtist]::new($resp.Content)
        return $resp.Content
    }
}