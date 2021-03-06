class DiscogsPaging {
    [int]$CurrentPage
    [int]$TotalPages
    [int]$ItemsTotal
    [int]$ItemsPerPage
    [string]$FirstPageURL
    [string]$LastPageURL
    [string]$PrevPageURL
    [string]$NextPageURL

    # ctor
    DiscogsPaging([string]$JSONIN) {
        $JSON = $JSONIN | ConvertFrom-Json
        $This.CurrentPage = $JSON.page
        $This.TotalPages = $JSON.Pages
        $This.ItemsTotal = $JSON.items
        $This.ItemsPerPage = $JSON.'per_page'
        $This.FirstPageURL = $JSON.urls.first
        $This.LastPageURL = $JSON.urls.last
        $This.PrevPageURL = $JSON.urls.prev
        $This.NextPageURL = $JSON.urls.next
    }
    DiscogsPaging() {
        # Default
    }
}

#New-Object -TypeName 'DiscogsPaging' -ArgumentList @($JSONString)


<#

"pagination": {
    "page": 2,
    "pages": 30,
    "items": 2255,
    "per_page": 75,
    "urls":
        {
            "first": "https://api.discogs.com/artists/1/releases?page=1&per_page=75",
            "prev": "https://api.discogs.com/artists/1/releases?page=1&per_page=75",
            "next": "https://api.discogs.com/artists/1/releases?page=3&per_page=75",
            "last": "https://api.discogs.com/artists/1/releases?page=30&per_page=75"
        }
    }
},
#>