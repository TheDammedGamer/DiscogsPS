function Add-URIArgument {
    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter( Position=0,Mandatory=$true )] [string]$Key,
        [Parameter( Position=1,Mandatory=$true )] [string]$Value
    )
    #Write it out to the needed format and replace spaces within the value string
    #Also trim the value object
    $out = $key + '=' + $value.Trim().Replace(' ', '%20')
    Write-Verbose "Adding URI Argument: '$out'"
    return $out
}