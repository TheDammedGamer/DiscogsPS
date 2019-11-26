class DiscogsUserData {
    [bool]$InCollection
    [bool]$InWantList

    DiscogsUserData($JSON) {
        $this.InCollection = $JSON.in_collection
        $this.InWantList = $JSON.in_wantlist
    }
}


<#

"user_data":  {
        "in_collection":  false,
        "in_wantlist":  false
    },

    #>