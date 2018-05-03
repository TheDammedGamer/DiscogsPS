
function Convert-URIArguments {
    [CmdletBinding()]
    [OutputType([string])]
    param (
        # Use Artist ID
        [Parameter(Position=0, Mandatory=$true)][string]$URI,
        [Parameter(Position=1, Mandatory=$false)][string[]]$URIArgs
    )

    if ($URIArgs.Count -ge 1) {
        Write-Verbose -Message $("URI Arguments: " + $URIArgs.Count.ToString())
        $StringToAppend = ''
        for ($i = 0; $i -lt $URIargs.Count; $i++) {
            if ($i -eq 0) {
                #First Loop
                $StringToAppend = $StringToAppend + '?' + $URIargs[$i]
            } else {
                #Normal loop
                $StringToAppend = $StringToAppend + '&' + $URIargs[$i]
            }
        }
        $uri = $uri + $StringToAppend
    }
    Write-Verbose -Message "Full URI: $uri"

    return $uri
}