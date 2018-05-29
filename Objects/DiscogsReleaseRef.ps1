
class DiscogsReleaseRef {
    [string]$Status
    [string]$ThumbNailImageURL
    [string]$Title
    [string]$Format
    [string]$LabelName
    [string]$Role
    [int]$Year
    [string]$ResourceURL
    [string]$Artist
    [string]$Type
    [int]$ID
    DiscogsReleaseRef([string]$stat, [string]$imgurl, [string]$reltitle, [string]$form, [string]$label, [string]$relrole, [int]$relyear, [string]$resurl, [string]$relartist, [string]$reltype, [int]$relid) {
        $this.Status = $stat
        $this.ThumbNailImageURL = $imgurl
        $this.Title = $reltitle
        $this.Format = $form
        $this.LabelName = $label
        $this.Role = $relrole
        $this.Year = $relyear
        $this.ResourceURL = $resurl
        $this.Artist = $relartist
        $this.Type = $reltype
        $this.ID = $relid
    }
    DiscogsReleaseRef([string]$JSONIN) {
        $JOSN = $JSONIN | ConvertFrom-Json
        $this.Status = $JOSN.status
        $this.ThumbNailImageURL = $JOSN.thumb
        $this.Title = $JOSN.title
        $this.Format = $JOSN.format
        $this.LabelName = $JOSN.label
        $this.Role = $JOSN.role
        $this.Year = $JOSN.year
        $this.ResourceURL = $JOSN.resource_url
        $this.Artist = $JOSN.artist
        $this.Type = $JOSN.type
        $this.ID = $JOSN.id
    }
    DiscogsReleaseRef() {
        #Default Constructor
    }
}



<#




JSON:
{
    "status":  "Accepted",
    "thumb":  "https://img.discogs.com/fGB2XFcXkHx5YuHHwxpNBpji1J4=/fit-in/150x150/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/R-9833515-1487056796-7685.jpeg.jpg",
    "title":  "Hello Little Girl / Till There Was You",
    "format":  "Acetate, 10\", Mono",
    "label":  "Personal Recording Department",
    "role":  "Main",
    "year":  1962,
    "resource_url":  "https://api.discogs.com/releases/9833515",
    "artist":  "The Beatles",
    "type":  "release",
    "id":  9833515
}

PS:
status       : Accepted
thumb        : https://img.discogs.com/fGB2XFcXkHx5YuHHwxpNBpji1J4=/fit-in/150x150/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/R-9833515-1487056796-7685.jpeg.jpg
title        : Hello Little Girl / Till There Was You
format       : Acetate, 10", Mono
label        : Personal Recording Department
role         : Main
year         : 1962
resource_url : https://api.discogs.com/releases/9833515
artist       : The Beatles
type         : release
id           : 9833515


---
9853448
#>