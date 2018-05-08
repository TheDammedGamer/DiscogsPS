class DiscogsImage {
    [string]$URL
    [int]$Height
    [int]$Width
    [string]$ResourceURL
    [DiscogsImageType]$Type
    [string]$URI150 #ThumbNail

    #Constructor
    DiscogsImage([string]$uri, [int]$height, [int]$width, [string]$resurl, [DiscogsImageType]$imgtype, [string]$uri150) {
        $this.URL = $uri
        $this.Height = $height
        $this.Width = $width
        $this.ResourceURL = $resurl
        $this.Type = $imgtype
        $this.URI150 = $uri150
    }
    DiscogsImage () {

    }
}

enum DiscogsImageType {
    Primary = 0
    Secondary = 1
    Other = 2
}

<#

"images":  [
        {
            "uri":  "https://img.discogs.com/GkwmGhLSzPg2iiM89LbicJuJy7M=/600x315/smart/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/A-3210013-1503324969-8384.jpeg.jpg",
            "height":  315,
            "width":  600,
            "resource_url":  "https://img.discogs.com/GkwmGhLSzPg2iiM89LbicJuJy7M=/600x315/smart/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/A-3210013-1503324969-8384.jpeg.jpg",
            "type":  "primary",
            "uri150":  "https://img.discogs.com/3gwtuuO2ptTavzkGFTG9-EgflwQ=/150x150/smart/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/A-3210013-1503324969-8384.jpeg.jpg"
        },
        {
            "uri":  "https://img.discogs.com/HvMQWGlGwsFD-5aI77_rQLCPrT8=/600x399/smart/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/A-3210013-1503324968-6792.jpeg.jpg",
            "height":  399,
            "width":  600,
            "resource_url":  "https://img.discogs.com/HvMQWGlGwsFD-5aI77_rQLCPrT8=/600x399/smart/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/A-3210013-1503324968-6792.jpeg.jpg",
            "type":  "secondary",
            "uri150":  "https://img.discogs.com/jk99qWy-6HcI2K0H1VfEXLCGDrI=/150x150/smart/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/A-3210013-1503324968-6792.jpeg.jpg"
        },
        {
            "uri":  "https://img.discogs.com/-9bSmVhgm0TYxbP5OWCqRDZGBqw=/600x415/smart/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/A-3210013-1503324968-3013.jpeg.jpg",
            "height":  415,
            "width":  600,
            "resource_url":  "https://img.discogs.com/-9bSmVhgm0TYxbP5OWCqRDZGBqw=/600x415/smart/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/A-3210013-1503324968-3013.jpeg.jpg",
            "type":  "secondary",
            "uri150":  "https://img.discogs.com/fji_SBUHPdyoG7pRhYtZYsb62bs=/150x150/smart/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/A-3210013-1503324968-3013.jpeg.jpg"
        },
        {
            "uri":  "https://img.discogs.com/8Xbvo-mx8zY1tM5U5Nlm3vH9w7A=/600x443/smart/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/A-3210013-1503324968-4861.jpeg.jpg",
            "height":  443,
            "width":  600,
            "resource_url":  "https://img.discogs.com/8Xbvo-mx8zY1tM5U5Nlm3vH9w7A=/600x443/smart/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/A-3210013-1503324968-4861.jpeg.jpg",
            "type":  "secondary",
            "uri150":  "https://img.discogs.com/474HazV1XC1oNjnzqGX97UWHapk=/150x150/smart/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/A-3210013-1503324968-4861.jpeg.jpg"
        }
    ]

#>