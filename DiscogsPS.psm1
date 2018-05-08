# Implement your module commands in this script.

# Dot Source every file to include it in the module

Write-Verbose -Message "Importing Objects from Module definition"

#### Objects
. $PSScriptRoot\Objects\DiscogsArtistMember.ps1
. $PSScriptRoot\Objects\DiscogsArtistStub.ps1
. $PSScriptRoot\Objects\DiscogsImage.ps1
. $PSScriptRoot\Objects\DiscogsPaging.ps1
. $PSScriptRoot\Objects\DiscogsMasterStub.ps1
. $PSScriptRoot\Objects\DiscogsPaging.ps1
. $PSScriptRoot\Objects\DiscogsRelease.ps1
. $PSScriptRoot\Objects\DiscogsReleaseStub.ps1
. $PSScriptRoot\Objects\DiscogsArtist.ps1

Write-Verbose -Message "Importing Module Helper Functions"
. .\HelperFunctions\Convert-URIArguments.ps1
. .\HelperFunctions\Add-URIArguments.ps1

Write-Verbose -Message "Importing Module Functions"
### Functions
. $PSScriptRoot\Functions\Get-DiscogsPSArtist.ps1
. $PSScriptRoot\Functions\Get-DiscogsPSArtistReleases.ps1
. $PSScriptRoot\Functions\Get-DiscogsPSRelease.ps1
. $PSScriptRoot\Functions\Search-DiscogsPSDatabase.ps1
. $PSScriptRoot\Functions\Get-DiscogsPSLabel.ps1
. $PSScriptRoot\Functions\Get-DiscogsPSLabelReleases.ps1
. $PSScriptRoot\Functions\Get-DiscogsPSMaster.ps1
. $PSScriptRoot\Functions\Get-DiscogsPSReleaseRating.ps1
. $PSScriptRoot\Functions\Get-DiscogsPSReleaseRatingByUser.ps1


# Export only the functions using PowerShell standard verb-noun naming.
# Be sure to list each exported functions in the FunctionsToExport field of the module manifest file.
# This improves performance of command discovery in PowerShell.
Export-ModuleMember -Function *-*
