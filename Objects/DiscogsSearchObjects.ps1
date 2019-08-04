artist
master
release

class DiscogsSearchMaster {
    [String[]]$Style
    [String[]]$Barcode
    [String]$Thumbnail
    [String]$WebURI
    [String]$Title
    [String]$Country #Country Code
    [String[]]$Format
    [DiscogsSearchUserData]$UserData
    [DiscogsSearchReleaseCommunity]$Community
    [String[]]$Label
    [String]$CoverImage
    [String]$CatalogueNum
    [String]$MasterURL
    [Int32]$Year
    [String[]]$Genre
    [String]$ResourceURL
    [Int32]$MasterId
    [String]$Type
    [Int32]$ID

}


class DiscogsSearchReleaseCommunity {
    [Int32]$Want
    [Int32]$Have
    DiscogsSearchReleaseCommunity([Int32]$WantIn, [Int32]$HaveIn) {
        $this.Want = $WantIn
        $this.Have = $HaveIn
    }
}


#region hide
<#
{
    "style":  [
                  "Alternative Rock"
              ],

    "barcode":  [
                    "7 24385 52291 8",
                    "7243 8 57331 1 6",
                    "7243 8 57331 1 5",
                    "LC 0299",
                    "bel BIEM",
                    "NODATA 0X2A-1-1-",
                    "I L??? Y??, Y?? A?? A W???????? P??s?? V???? B????",
                    "NODATA 0X2B-1-1-",
                    "I\u0027? F??? O? E????s??s? I\u0027? G???? P????s",
                    "NODATA 0X2C-1-1-",
                    "I\u0027?? B? H???? T? H??? Y??",
                    "NODATA 0X2D-1-1-",
                    "I\u0027? A? I???????? P??s??, W???? Y?? L??? T? C??? H??? W??? M??",
                    "D"
                ],

    "thumb":  "https://img.discogs.com/-O2vK48Jfu-hFnwuu9KKubqWjUw=/fit-in/150x150/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/R-4950798-1387745762-1902.jpeg.jpg",
    "uri":  "/Radiohead-OK-Computer/master/21491",
    "title":  "Radiohead - OK Computer",
    "country":  "UK",
    "format":  [
                   "Vinyl",
                   "LP",
                   "Album"
               ],
    "user_data":  {
                      "in_collection":  false,
                      "in_wantlist":  false
                  },

    "community":  {
                      "want":  47619,
                      "have":  66893
                  },
    "label":  [
                  "Parlophone",
                  "Parlophone",
                  "EMI",
                  "EMI",
                  "Mayfair Studios",
                  "Abbey Road Studios",
                  "Air Lyndhurst Hall",
                  "Courtyard Studio",
                  "The Church, London",
                  "EMI Records Ltd.",
                  "EMI Records Ltd.",
                  "EMI Records"
              ],
    "cover_image":  "https://img.discogs.com/1Bqtd-Nn11yTlidUcGemjOuLFRI=/fit-in/600x600/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/R-4950798-1387745762-1902.jpeg.jpg",
    "catno":  "NODATA 02",
                    #>
#endregion hide
<#
    "master_url":  "https://api.discogs.com/masters/21491",
    "year":  "1997",
    "genre":  [
                  "Electronic",
                  "Rock"
              ],
    "resource_url":  "https://api.discogs.com/masters/21491",
    "master_id":  21491,
    "type":  "master",
    "id":  21491
}


#>







class DiscogsSearchArtist {
    [String]$Thumbnail
    [String]$Title
    [DiscogsSearchUserData]$UserData
    [String]$MasterURL
    [String]$URI
    [String]$CoverImage
    [String]$ResourceURL
    [String]$MasterId
    [String]$Type
    [Int32]$ID
}

class DiscogsSearchUserData {
    [bool]$InCollection
    [bool]$InWantlist
    DiscogsSearchUserData([bool]$collection, [bool]$wantlist) {
        $this.InCollection = $collection
        $this.InWantlist = $wantlist
    }
}

<#

{
    "thumb":  "https://img.discogs.com/3gwtuuO2ptTavzkGFTG9-EgflwQ=/150x150/smart/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/A-3210013-1503324969-8384.jpeg.jpg",
    "title":  "One Ok Rock",
    "user_data":  {
                      "in_collection":  false,
                      "in_wantlist":  false
                  },
    "master_url":  null,
    "uri":  "/artist/3210013-One-Ok-Rock",
    "cover_image":  "https://img.discogs.com/GkwmGhLSzPg2iiM89LbicJuJy7M=/600x315/smart/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/A-3210013-1503324969-8384.jpeg.jpg",
    "resource_url":  "https://api.discogs.com/artists/3210013",
    "master_id":  null,
    "type":  "artist",
    "id":  3210013
}


#>