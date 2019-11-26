class DiscogsArtistMember {
    [bool]$Active
    [string]$RefURL
    [int]$ID
    [string]$Name

    #Constructor
    DiscogsArtistMember([bool]$IsActive, [string]$URL, [int]$id, [string]$name) {
        $this.Active = $IsActive
        $this.RefURL = $URL
        $this.ID = $id
        $this.Name = $name
    }
    DiscogsArtistMember() {

    }
}
<#

New-Object -TypeName 'DiscogsArtistMember' -ArgumentList @($IsActive, $RefURL, $id, $Name)

"members":  [
        {
            "active":  false,
            "resource_url":  "https://api.discogs.com/artists/3846925",
            "id":  3846925,
            "name":  "Alex (351)"
        },
        {
            "active":  true,
            "resource_url":  "https://api.discogs.com/artists/4075342",
            "id":  4075342,
            "name":  "Ryota (10)"
        },
        {
            "active":  true,
            "resource_url":  "https://api.discogs.com/artists/3846904",
            "id":  3846904,
            "name":  "Taka (35)"
        },
        {
            "active":  true,
            "resource_url":  "https://api.discogs.com/artists/3846902",
            "id":  3846902,
            "name":  "Tomoya (10)"
        },
        {
            "active":  true,
            "resource_url":  "https://api.discogs.com/artists/3846903",
            "id":  3846903,
            "name":  "Toru (17)"
        },
        {
            "active":  false,
            "resource_url":  "https://api.discogs.com/artists/6224741",
            "id":  6224741,
            "name":  "You (51)"
        }
    ]

#>
