class DiscogsCommunityContribution {
    [String]$Status # Could be Enum
    [DiscogsRating]$Rating
    [Int32]$Want
    [DiscogsContributor[]]$Contributors
    [Int32]$Have
    [DiscogsContributor]$Submitter
    [String]$DataQuality # Could be Enum
    DiscogsCommunityContribution($ParsedJSON) {
        $this.Status = $ParsedJSON.Status
        $this.Rating = [DiscogsRating]::new($ParsedJSON.rating.count, $ParsedJSON.rating.average)
        $this.Want = $ParsedJSON.want
        $this.Have = $ParsedJSON.have
        $this.DataQuality = $ParsedJSON.data_quality
        $this.Submitter = [DiscogsContributor]::new($ParsedJSON.submitter.username, $ParsedJSON.submitter.resource_url)

        $contributorsarray = @()
        $ParsedJSON.contributors | ForEach-Object {
            $contributorsarray += [DiscogsContributor]::new($_.username, $_.resource_url)
        }
        $this.Contributors = $contributorsarray
    }
}



class DiscogsRating {
    [Int32]$Count
    [Int32]$Average
    DiscogsRating([Int32]$coun, [Int32]$averag) {
        $this.Average = $averag
        $this.Count = $coun
    }
}

class DiscogsContributor {
    [String]$UserName
    [String]$ResourceURL
    DiscogsContributor([String]$Name, [String]$URL) {
        $this.UserName = $Name
        $this.ResourceURL = $URL
    }
}