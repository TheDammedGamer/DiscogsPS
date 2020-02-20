function Invoke-DiscogsPaging {
    [CmdletBinding()]
    param (
        [string]$IntialURI,
        [System.Collections.Generic.List[DiscogsPS.Lib.APIError]]$PossibleErrors
    )

    begin {
        $UA = 'DiscogsPS/1.0 +https://github.com/TheDammedGamer/DiscogsPS'

        $ObjectsOut = [System.Collections.Generic.List[Object]]::new()

        $Paging = ''
    }

    process {
        try {
            Write-Verbose -Message "Getting Page: 1"
            $resp = Invoke-WebRequest -Uri $URI -UseBasicParsing -Method GET -UserAgent $UA
            $page1 = [DiscogsPS.Lib.ArtistReleasesPage]::Parse($resp.Content)
            $Paging = $Page1.Pagination
            $ObjectsOut.AddRange($Page1.Releases)

        } catch {
            if ($resp.Content.Length -gt 1) {
                $ErrorList | Where-Object { $_.IsSimple -eq $false } | ForEach-Object {
                    if (($_.StatusCode -eq $resp.StatusCode ) -and ($_.APIMessage -eq $($resp.Content | ConvertFrom-Json).message)) {
                        $_.Throw()
                    }
                }
            } else {
                $ErrorList | Where-Object { $_.IsSimple -eq $true } | ForEach-Object {
                    if ($_.StatusCode -eq $resp.StatusCode ) {
                        $_.Throw()
                    }
                }
            }
            throw $_
        }

        if ($Paging.TotalPages -gt 1) {
            Write-Verbose -Message "Total items Left To Get: $($Paging.ItemsTotal)"
            Write-Verbose -Message "Getting $($Paging.TotalPages) Pages"
            Write-Verbose -Message "Pages left to Get: $($Paging.TotalPages - 1)"

            Start-Sleep -Seconds 1 # Wait for a Second to ensure we don't get Ratelimited

            # Stats the Resuls of the first Page
            $ObjectsOut += $resp.Content | ConvertFrom-Json | Select-Object -ExpandProperty releases

            [DiscogsPS.Lib.Paging]$currentPage = $Paging
            for ($page = 2; $page -lt $Paging.TotalPages; $page++) {
                Write-Progress -Activity "Getting Pages" -Status "Progress:" -PercentComplete ($page/$Paging.TotalPages*100) -CurrentOperation "Getting Page: $page/$($Paging.TotalPages)"

                Write-Verbose -Message "Getting Page: $page/$($Paging.TotalPages)"
                try {
                    Write-Verbose -Message "Getting URL: $($currentPage.NextPageURI)"
                    $PageResp = Invoke-WebRequest -Uri $currentPage.NextPageURI -UseBasicParsing -Method GET -UserAgent $UA
                    $PageItem = [DiscogsPS.Lib.SearchPage]::Parse($PageResp.Content)
                    $currentPage = $PageItem.Pagination
                    $ObjectsOut.AddRange($PageItem.Releases)
                } catch {
                    if ($PageResp.Content.Length -gt 1) {
                        $ErrorList | Where-Object { $_.IsSimple -eq $false } | ForEach-Object {
                            if (($_.StatusCode -eq $PageResp.StatusCode ) -and ($_.APIMessage -eq $($PageResp.Content | ConvertFrom-Json).message)) {
                                $_.Throw()
                            }
                        }
                    } else {
                        $ErrorList | Where-Object { $_.IsSimple -eq $true } | ForEach-Object {
                            if ($_.StatusCode -eq $PageResp.StatusCode ) {
                                $_.Throw()
                            }
                        }
                    }
                    throw $_
                }
                Start-Sleep -Seconds 1 # Wait for a Second to ensure we don't get Ratelimited
            }
        }
    }

    end {
        return $ObjectsOut;
    }
}
$ErrorList = [System.Collections.Generic.List[DiscogsPS.Lib.APIError]]::new()
$ErrorList.Add([DiscogsPS.Lib.APIError]::SimpleError(404, "Error 404 from Discogs API Check Connection to https://api.discogs.com"))
$ErrorList.Add([DiscogsPS.Lib.APIError]::ComplexError(404, "Artist not found on Discogs", "Artist not found."))


