#Load Sub Objects
#. $PSScriptRoot\Object\DiscogsArtistMember.ps1
#. $PSScriptRoot\Object\DiscogsImage.ps1

class DiscogsArtist {
    [string]$ArtistProfile
    [string]$Name
    [string]$ReleaseURL
    [int]$id
    [DiscogsArtistMember[]]$Members
    [DiscogsImage[]]$Images
    [string]$DataQuality
    [string]$WebURL
    [string[]]$URLs
    [string]$RefURL

    #Constructor
    DiscogsArtist([string]$JsonIn) {
        $JObject = $JsonIn | ConvertFrom-Json
        $this.ArtistProfile = $JObject.Profile
        $this.Name = $JObject.name
        $this.ReleaseURL = $JObject.'releases_url'
        $this.id = $JObject.id
        $this.DataQuality = $JObject.'data_quality'
        $this.WebURL = $JObject.uri
        $this.RefURL = $JObject.'resource_url'
        $this.URLS = $JObject.urls

        #Parse Member Objects
        $MembersArray = @()
        $JObject.members | ForEach-Object {
            $obj = [DiscogsArtistMember]::new($_.active, $_.'resource_url', $_.id, $_.name)

            $membersArray += $obj
        }

        $this.Members = $MembersArray

        #Parse Images Objects
        $ImagesArray = @()
        $JObject.members | ForEach-Object {
            $type = $_.Type
            $TypeEnum = ''
            switch ($type) {
                'primary' {
                    $TypeEnum = 0
                }
                'secondary' {
                    $TypeEnum = 1
                }
                Default {
                    $TypeEnum = 2
                    #Write-Warning "Unable to Parse Image Type, Image is of type: $type. Accountable types are 'primary', and 'secondary'"
                }
            }

            $obj = [DiscogsImage]::new($_.uri, $_.height, $_.width,  $_.'resource_url', $TypeEnum, $_.uri150)
            #[string]$uri, [int]$height, [int]$width, [string]$resurl, [DiscogsImageType]$imgtype, [string]$uri150

            $ImagesArray += $obj
        }

        $this.Images = $ImagesArray
    }

    DiscogsArtist() {

    }
}





<#
# JSON Object DEf example

{
    "profile":  "One Ok Rock is a Japanese Rock band formed in the summer of 2005. It was started by Toru with High School friends Alex and Ryota after each of them got their musical instruments. After that, Taka joined as their vocalist and they focused on performing shows in the Tokyo area.\r\n\r\nIn 2006 they independently released 2 mini albums. Because of their albums sales, their participation in relatively large festivals that summer and their energetic shows in the outskirts of Tokyo, they were noticed by a foreign record company.\r\n\r\nIn March 2007 Tomoya officially joined the group and the band finally made their major debut by releasing their first single 内秘心書(Naihi Shinsho) on April 25th.\r\n\r\nThe band’s name, One Ok Rock, came from “one o’clock,” the time that the band used to practice on weekends. However, noticing that the Japanese language made no distinction between r’s and l’s, they changed “o’clock” to “o’crock” (or “o’krock”) which then was separated to become “ok rock”.\r\n\r\nOn April 5th, 2009, Alex was arrested for allegedly groping a female prep school student. They were going to release the single 「Ａｒｏｕｎｄ　ザ　ｗｏｒｌｄ　少年」on May 6th but this was cancelled. The song was also going to be used for the drama ‘God Hand Teru’ but was replaced. Also, a nationwide tour was cancelled because of the incident. On May 15th, it was announced the Alex has left the group and the other 4 members would continue activites in the summer without him.\r\n\r\nONE OK ROCK continued as a four-member group and made a comeback with a live concert tour that started on September 5, 2009, titled Overcome Emotion. Their first release afterwards was their fourth single, “Kanzen Kankaku Dreamer”, on February 3, 2010. The band followed up with their fourth album, Niche Syndrome, which was released on June 9. Their next single, “Answer is Near”, was released on February 16, 2011.\r\n\r\nThe band released their first double A-side single “Re:make/No Scared” on July 20, 2011, the latter song being the main theme for the Black Rock Shooter: The Game video game. The band’s fifth album, Zankyo Reference, was released on October 5, 2011. Their latest single, “The Beginning”, which is used as a theme for the live action movie adaptation of the Rurouni Kenshin manga, was released on August 22, 2012.",
    "releases_url":  "https://api.discogs.com/artists/3210013/releases",
    "name":  "One Ok Rock",
    "uri":  "https://www.discogs.com/artist/3210013-One-Ok-Rock",
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
    ],
    "urls":  [
        "http://www.oneokrock.com/",
        "https://www.facebook.com/ONEOKROCK",
        "https://www.instagram.com/oneokrockofficial",
        "https://twitter.com/ONEOKROCK_japan",
        "https://www.youtube.com/channel/UCzycs8MqvIY4nXWwS-v4J9g"
    ],
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
    ],
    "resource_url":  "https://api.discogs.com/artists/3210013",
    "id":  3210013,
    "data_quality":  "Needs Vote"
}


#>