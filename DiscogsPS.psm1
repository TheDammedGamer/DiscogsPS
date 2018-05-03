# Implement your module commands in this script.

# Dot Source every file to include it in the module

#### Objects
. $PSScriptRoot\Objects\DiscogsArtistMember.ps1
. $PSScriptRoot\Objects\DiscogsArtistSub.ps1
. $PSScriptRoot\Objects\DiscogsImage.ps1
. $PSScriptRoot\Objects\DiscogsArtist.ps1
. $PSScriptRoot\Objects\DiscogsPaging.ps1

### Functions
. $PSScriptRoot\Functions\Get-DiscogsPSArtist.ps1
. $PSScriptRoot\Functions\Get-DiscogsPSArtistReleases.ps1
. $PSScriptRoot\Functions\Get-DiscogsPSRelease.ps1
. $PSScriptRoot\Functions\Search-DiscogsPSDatabase.ps1


# Export only the functions using PowerShell standard verb-noun naming.
# Be sure to list each exported functions in the FunctionsToExport field of the module manifest file.
# This improves performance of command discovery in PowerShell.
Export-ModuleMember -Function *-*
