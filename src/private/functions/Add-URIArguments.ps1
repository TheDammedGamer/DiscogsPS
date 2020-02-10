function Add-URIArgument {
    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter( Position=0,Mandatory=$true )] [string]$Key,
        [Parameter( Position=1,Mandatory=$true )] [string]$Value
    )
    #Write it out to the needed format and replace spaces within the value string
    #Also trim the value object

    $out = $key + '=' + [System.Web.HttpUtility]::UrlEncode($value.Trim())
    Write-Verbose "Adding URI Argument: '$out'"
    return $out
}