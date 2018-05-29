class DiscogsReleaseStub
{
    [string[]]$Style
    [string]$Thumbnail
    [string[]]$Format
    [string]$CountryCode
    [string[]]$Barcode
    [string]$WebsiteURL # Apply transformation in ctor
    [string[]]$Genre
    [string]$CatNo
    [int]$Year
    [string]$CoverImage
    [string]$Title
    [string]$ResourceURL
    [string[]]$Label
    [int]$ID
}

class DiscogsStubCommunity {
    [string]$Want
    [string]$Have
}

class DiscogsUserData {

}

<#
{
    "style":  [
                  "Hard Rock",
                  "Grunge"
              ],
    "thumb":  "https://img.discogs.com/_3InDqhrClpZFPbdzJabGHo6wxo=/fit-in/150x150/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/R-1035080-1210409689.jpeg.jpg",
    "format":  [
                   "Vinyl",
                   "LP",
                   "Album"
               ],
    "country":  "US",
    "barcode":  [
                    "0 18861-0201-1 2",
                    "SST-201-A A RELIGOUS MAN MIGHT THINK WE\u0027RE EVIL... S-206/0 L-31565 kdisc",
                    "SST-201-B A RATIONAL MAN MIGHT THINK WE\u0027RE RELIGIOUS... S-206/1 L-31565-X kdisc"
                ],
    "uri":  "/Soundgarden-Ultramega-OK/release/1035080",
    "community":  {
                      "want":  417,
                      "have":  1201
                  },
    "user_data":  {
                      "in_collection":  false,
                      "in_wantlist":  false
                  },
    "genre":  [
                  "Rock"
              ],
    "catno":  "SST 201",
    "year":  "1988",
    "cover_image":  "https://img.discogs.com/2w2zn1_mdI4pWf9FeZ-tv5PnIOQ=/fit-in/549x546/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/R-1035080-1210409689.jpeg.jpg",
    "title":  "Soundgarden - Ultramega OK",
    "resource_url":  "https://api.discogs.com/releases/1035080",
    "label":  [
                  "SST Records",
                  "Loud Love Music",
                  "SST Records",
                  "Rainbo Records",
                  "Rainbo Records",
                  "Dogfish Mobile Unit",
                  "Dogfish Studios",
                  "Pace Studios",
                  "Greg Lee Processing",
                  "K Disc Mastering"
              ],
    "type":  "release",
    "id":  1035080
}

#>