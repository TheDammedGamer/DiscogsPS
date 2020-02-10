#Import The Module to ensure we have the command and all related objects
Import-Module .\DiscogsPS.psd1 -Force

$Token = Read-Host -Prompt "Enter a Token for the test to use."

#Using Nickelback (108713) as base artist Object
describe 'Get-DiscogsPSArtist Tests' {

    it 'Checking Whether the API connects and the function returns an object' {
        { Get-DiscogsPSArtist -ArtistID 108713 -Token $Token -ErrorAction Stop } | Should Not Throw
    }

    it 'Checking whether the Function returns an error for an invalid Artist ID' {
        { Get-DiscogsPSArtist -ArtistID $([int]::MinValue) -Token $Token -ErrorAction Stop} | Should Throw
    }
    Context -Name "Check Artist Return is corrext"  {
        #Grabbing the artists to refernce for tests
        $Artist = Get-DiscogsPSArtist -ArtistID 108713 -Token $Token
        it 'Artist Name should return "Nickelback"' {
            $Artist.Name | Should be "Nickelback"
        }
        it 'Artist ID should return 108713' {
            $Artist.id | Should be 108713
        }
        it 'Web URL should return "https://www.discogs.com/artist/108713-Nickelback"' {
            $Artist.WebURL | Should be "https://www.discogs.com/artist/108713-Nickelback"
        }
        it 'Reference URL should return "https://api.discogs.com/artists/108713"' {
            $Artist.RefURL | Should be "https://api.discogs.com/artists/108713"
        }
    }
}