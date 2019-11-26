# TODO: Method To Get Artist
# TODO: Add Pipe input on Get-DiscogsPSArtist
class DiscogsArtistRef {
    [string]$Join
    [string]$Name
    [string]$ANV
    [string]$Tracks
    [string]$Role
    [string]$ResourceURL
    [int]$ID

    #Constructor
    DiscogsArtistRef([Object]$JSONIn) {
        $this.Join = $JSONIn.join
        $this.Name = $JSONIn.name
        $this.ANV = $JSONIn.anv
        $this.Tracks = $JSONIn.tracks
        $this.Role = $JSONIn.role
        $this.ResourceURL = $JSONIn.'resource_url'
        $this.id = $JSONIn.id
    }
}

#$obj = [DiscogsArtistRef]::new($JsonConverted)

<#{
    "join": "",
    "name": "The Beat Brothers (2)",
    "anv": "",
    "tracks": "",
    "role": "",
    "resource_url": "https://api.discogs.com/artists/380838",
    "id": 380838
}#>