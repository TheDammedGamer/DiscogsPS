# Implement your module commands in this script.

# Dot Source every file to include it in the module
#### Objects
. .\Objects\DiscogsArtist.ps1
. .\Objects\DiscogsArtistMember.ps1
. .\Objects\DiscogsArtistSub.ps1
. .\Objects\DiscogsImage.ps1

### Functions
. .\Functions\Get-DiscogsPSArtist.ps1
. .\Functions\Get-DiscogsPSArtistReleases.ps1
. .\Functions\Get-DiscogsPSRelease.ps1
. .\Functions\Search-DiscogsPSDatabase.ps1


# Export only the functions using PowerShell standard verb-noun naming.
# Be sure to list each exported functions in the FunctionsToExport field of the module manifest file.
# This improves performance of command discovery in PowerShell.
Export-ModuleMember -Function *-*
