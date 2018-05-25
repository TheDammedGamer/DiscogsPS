class DiscogsTracklistItem {
    [DiscogsTrackDuration] $Duration
    [int] $Position
    [string] $Type_
    [string] $ExtraArtists
    [string] $Title
    DiscogsTracklistItem ([string]$JsonIN) {
        $JSON = $JsonIN | ConvertFrom-Json
        $this.Duration = New-Object -TypeName 'DiscogsTrackDuration' -ArgumentList @($JSON.duration)
        $this.Position = [int]::Parse($JSON.position)
        $this.Type_ = $JSON.type_
        $this.ExtraArtists = $JSON.extraartists
        $this.Title = $JSON.title

    }
    DiscogsTracklistItem ([string]$dur, [string]$pos, [string]$type, [string]$otherArtists, [string]$tracktitle) {
        $this.Duration = $dur
        $this.Position = [int]::Parse($pos)
        $this.Type_ = $type
        $this.ExtraArtists= $otherArtists
        $this.Title = $tracktitle
    }
    DiscogsTracklistItem () {
        #Defualt Empty Constructor
    }
}
#New-Object -TypeName 'DiscogsTracklistItem' -ArgumentList @($JSONstr)




<#
{
    "duration": "",
    "position": "B",
    "type_": "track",
    "extraartists": "",
    "title": "The Saints (When The Saints Go Marching In)"
}
#>