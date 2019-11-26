class DiscogsMaster
{
    [string[]]$Styles
    [string[]]$Genres
    [string]$ReleaseURL
    [int]$NumberForSale
    [DiscogsVideoRef]$Videos
    [string]$Title
    [int]$ReleaseID
    [DiscogsArtistRef]$Artists
    [string]$WebURL
    [string]$VersionsURI
    [double]$LowestPrice
    [int]$Year
    [DiscogsImage[]]$Images
    [string]$ResourceURI
    [DiscogsTracklistItem]$Tracklist
    [int]$ID
    [string]$DataQuality

    DiscogsMaster($JSONIn) {
        $this.Styles = $JSONIn.styles
        $this.Genres = $JSONIn.genres
        $this.ReleaseURL = $JSONIn.main_release_url
        $this.NumberForSale = $JSONIn.num_for_sale

        $this.Videos = @()
        $JSONIn.videos | ForEach-Object {
            $this.Videos += [DiscogsVideoRef]::New($_)
        }

        $this.Title = $JSONIn.title
        $this.ReleaseID = $JSONIn.main_release

        $this.Artists = @()
        $JSONIn.artists | ForEach-Object {
            $this.Artists += [DiscogsArtistRef]::New($_)
        }

        $this.WebURL = $JSONIn.uri
        $this.VersionsURI = $JSONIn.versions_url
        $this.LowestPrice = $JSONIn.lowest_price
        $this.Year = $JSONIn.year

        $this.Images = @()
        $JSONIn.images | ForEach-Object {
            $this.Images += [DiscogsImage]::New($_)
        }

        $this.ResourceURI = $JSONIn.resource_url

        $this.Tracklist = @()
        $JSONIn.tracklist | ForEach-Object {
            $this.Tracklist += [DiscogsTracklistItem]::New($_)
        }

        $this.Tracklist = $JSONIn.tracklist
        $this.ID = $JSONIn.id
        $this.DataQuality = $JSONIn.data_quality
    }
}
#TODO: Constructor

<#
{
    "styles": [
        "Rock & Roll"
    ],
    "genres": [
        "Rock"
    ],
    "main_release_url": "https://api.discogs.com/releases/1799589",
    "num_for_sale": 210,
    "videos": [
        {
            "duration": 166,
            "embed": true,
            "title": "My Bonnie-Tony Sheridan & The Beat Brothers",
            "description": "My Bonnie-Tony Sheridan & The Beat Brothers",
            "uri": "https://www.youtube.com/watch?v=13Gymo9Pd1o"
        },
        {
            "duration": 164,
            "embed": true,
            "title": "Tony Sheridan and The Beat Brothers My Bonnie",
            "description": "Tony Sheridan and The Beat Brothers My Bonnie",
            "uri": "https://www.youtube.com/watch?v=h2jnLBKgbHw"
        }
    ],
    "title": "My Bonnie",
    "main_release": 1799589,
    "artists": [
        {
            "join": "&",
            "name": "Tony Sheridan",
            "anv": "",
            "tracks": "",
            "role": "",
            "resource_url": "https://api.discogs.com/artists/261052",
            "id": 261052
        },
        {
            "join": "",
            "name": "The Beat Brothers (2)",
            "anv": "",
            "tracks": "",
            "role": "",
            "resource_url": "https://api.discogs.com/artists/380838",
            "id": 380838
        }
    ],
    "uri": "https://www.discogs.com/Tony-Sheridan-The-Beat-Brothers-My-Bonnie/master/119930",
    "versions_url": "https://api.discogs.com/masters/119930/versions",
    "lowest_price": 1.82,
    "year": 1961,
    "images": [
        {
            "uri": "https://img.discogs.com/Fy0unflyxzp21MHfQTTqdyqlWl0=/fit-in/500x501/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/R-1799589-1356435999-4145.jpeg.jpg",
            "height": 501,
            "width": 500,
            "resource_url": "https://img.discogs.com/Fy0unflyxzp21MHfQTTqdyqlWl0=/fit-in/500x501/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/R-1799589-1356435999-4145.jpeg.jpg",
            "type": "primary",
            "uri150": "https://img.discogs.com/wMqRz9ayeNUWpsYms4hiJ6ysubw=/fit-in/150x150/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/R-1799589-1356435999-4145.jpeg.jpg"
        },
        {
            "uri": "https://img.discogs.com/9pWoD6NPOsWsEe9edkTWrtP3Yww=/fit-in/450x440/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/R-1799589-1356436012-8093.jpeg.jpg",
            "height": 440,
            "width": 450,
            "resource_url": "https://img.discogs.com/9pWoD6NPOsWsEe9edkTWrtP3Yww=/fit-in/450x440/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/R-1799589-1356436012-8093.jpeg.jpg",
            "type": "secondary",
            "uri150": "https://img.discogs.com/jQA1E-gJD8GZYPbZMbvt8u4HGuM=/fit-in/150x150/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/R-1799589-1356436012-8093.jpeg.jpg"
        },
        {
            "uri": "https://img.discogs.com/b32wzPBLXs4KvFxau5AQZ3aTE9Q=/fit-in/500x501/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/R-1799589-1356436022-1276.jpeg.jpg",
            "height": 501,
            "width": 500,
            "resource_url": "https://img.discogs.com/b32wzPBLXs4KvFxau5AQZ3aTE9Q=/fit-in/500x501/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/R-1799589-1356436022-1276.jpeg.jpg",
            "type": "secondary",
            "uri150": "https://img.discogs.com/En8Ur_zRG2MK4lUNp2oBXh_X42E=/fit-in/150x150/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/R-1799589-1356436022-1276.jpeg.jpg"
        },
        {
            "uri": "https://img.discogs.com/UAv5OhvmihFIpCnG7jgFpvgiGXA=/fit-in/500x504/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/R-1799589-1356436032-5034.jpeg.jpg",
            "height": 504,
            "width": 500,
            "resource_url": "https://img.discogs.com/UAv5OhvmihFIpCnG7jgFpvgiGXA=/fit-in/500x504/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/R-1799589-1356436032-5034.jpeg.jpg",
            "type": "secondary",
            "uri150": "https://img.discogs.com/S07taqL5F-9kxjXQXW6gtMg3S5g=/fit-in/150x150/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/R-1799589-1356436032-5034.jpeg.jpg"
        },
        {
            "uri": "https://img.discogs.com/TUhhSxCyiNHWdrFrqZ4HOzP5c3I=/fit-in/600x608/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/R-1799589-1474782192-7201.jpeg.jpg",
            "height": 608,
            "width": 600,
            "resource_url": "https://img.discogs.com/TUhhSxCyiNHWdrFrqZ4HOzP5c3I=/fit-in/600x608/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/R-1799589-1474782192-7201.jpeg.jpg",
            "type": "secondary",
            "uri150": "https://img.discogs.com/5qj1yUdFVOUN4b_3i-GF5WBlaS4=/fit-in/150x150/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/R-1799589-1474782192-7201.jpeg.jpg"
        },
        {
            "uri": "https://img.discogs.com/snKG7zdx2AZf9-0HS14FJclZ9x0=/fit-in/600x266/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/R-1799589-1487692606-8976.jpeg.jpg",
            "height": 266,
            "width": 600,
            "resource_url": "https://img.discogs.com/snKG7zdx2AZf9-0HS14FJclZ9x0=/fit-in/600x266/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/R-1799589-1487692606-8976.jpeg.jpg",
            "type": "secondary",
            "uri150": "https://img.discogs.com/reRDo0bpWZZevTioQR663mFzLUo=/fit-in/150x150/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/R-1799589-1487692606-8976.jpeg.jpg"
        }
    ],
    "resource_url": "https://api.discogs.com/masters/119930",
    "tracklist": [
        {
            "duration": "",
            "position": "A",
            "type_": "track",
            "extraartists": "",
            "title": "My Bonnie (Mein Herz Ist Bei Dir Nur)"
        },
        {
            "duration": "",
            "position": "B",
            "type_": "track",
            "extraartists": "",
            "title": "The Saints (When The Saints Go Marching In)"
        }
    ],
    "id": 119930,
    "data_quality": "Correct"
}
#>