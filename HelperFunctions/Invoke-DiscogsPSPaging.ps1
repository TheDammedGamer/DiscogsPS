# Develoment Only
# Load Helper Fucntions
. .\HelperFunctions\Convert-URIArguments.ps1
. .\HelperFunctions\Add-URIArguments.ps1

#Load Needed Objects
. .\Objects\DiscogsPaging.ps1

function Invoke-DiscogsPSPaging {
    [CmdletBinding()]
    [OutputType([HashTable])]
    param (
        # Parameter help description
        [Parameter(Position=0, Mandatory=$true)][string]$Query,
        [Parameter(Position=1, Mandatory=$false)][string]$Token
    )

    begin {
    }

    process {

    }

    end {
    }
}