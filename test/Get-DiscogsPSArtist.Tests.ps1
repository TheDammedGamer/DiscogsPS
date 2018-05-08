#Import The Module to ensure we have the command and all related objects
Import-Module .\DiscogsPS.psd1 -Force

$Token = Read-Host -Prompt "Enter a Token for the test to use."

#Using Nickelback (108713) as base artist Object
describe 'Get-DiscogsPSArtist Tests' {

    it 'Checking Whether the API connects and the function returns a [DiscogsArtist]' {
        {$artist = Get-DiscogsPSArtist -ArtistID 108713 -Token $Token} | Should Not Throw
    }
    $CurrentErrors = $error.Count

    it 'Checking whether the Function returns an error for an invalid Artist ID' {
        {$artist = Get-DiscogsPSArtist -ArtistID $([int]::MaxValue) -Token $Token} | Should Throw
        $error.Count | Should Be $($CurrentErrors + 1)
    }

    #Grabbing the artists to refernce for tests
    $Artist = Get-DiscogsPSArtist -ArtistID 108713 -Token $Token
    it 'Artist Name should return "Nickelback"' {
        $Artist.Name | Should be "Nickelback"
    }
    it 'Artist Name should be a string' {
        $Artist.Name | Should BeOfType string
    }
    it 'Artist ID should return 108713' {
        $Artist.id | Should be 108713
    }
    it 'Artist ID should be a int' {
        $Artist.id | Should BeOfType int
    }
    it 'Web URL should return "https://www.discogs.com/artist/108713-Nickelback"' {
        $Artist.WebURL | Should be "https://www.discogs.com/artist/108713-Nickelback"
    }
    it 'Web URL should be a string' {
        $Artist.WebURL | Should BeOfType string
    }
    it 'Reference URL should return "https://api.discogs.com/artists/108713"' {
        $Artist.RefURL | Should be "https://api.discogs.com/artists/108713"
    }
    it 'Reference URL should be a string' {
        $Artist.RefURL | Should BeOfType string
    }
}