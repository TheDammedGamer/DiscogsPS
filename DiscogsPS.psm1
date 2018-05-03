# Implement your module commands in this script.

# Dot Source every file to include it in the module

#### Objects
. .\Objects\DiscogsArtistMember.ps1
. .\Objects\DiscogsArtistStub.ps1
. .\Objects\DiscogsImage.ps1
. .\Objects\DiscogsArtist.ps1
. .\Objects\DiscogsPaging.ps1
. .\Objects\DiscogsMasterStub.ps1
. .\Objects\DiscogsPaging.ps1
. .\Objects\DiscogsRelease.ps1
. .\Objects\DiscogsReleaseStub.ps1

### Functions
. .\Functions\Get-DiscogsPSArtist.ps1
. .\Functions\Get-DiscogsPSArtistReleases.ps1
. .\Functions\Get-DiscogsPSRelease.ps1
. .\Functions\Search-DiscogsPSDatabase.ps1
. .\Functions\Get-DiscogsPSLabel.ps1
. .\Functions\Get-DiscogsPSLabelReleases.ps1
. .\Functions\Get-DiscogsPSMaster.ps1
. .\Functions\Get-DiscogsPSReleaseRating.ps1
. .\Functions\Get-DiscogsPSReleaseRatingByUser.ps1


# Export only the functions using PowerShell standard verb-noun naming.
# Be sure to list each exported functions in the FunctionsToExport field of the module manifest file.
# This improves performance of command discovery in PowerShell.
Export-ModuleMember -Function *-*
