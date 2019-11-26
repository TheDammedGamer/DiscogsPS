class DiscogsVideoRef {
    [int]$Duration
    [bool]$Embed
    [string]$Title
    [string]$Description
    [string]$URI
    DiscogsVideoRef($JSONIN) {
        $this.Duration = $JSONIN.duration
        $this.Embed = $JSONIN.embed
        $this.Title = $JSONIN.title
        $this.Description = $JSONIN.description
        $this.URI = $JSONIN.uri
    }
}


<#
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
#>