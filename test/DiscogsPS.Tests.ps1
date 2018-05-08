$ModuleManifestName = '.\DiscogsPS.psd1'

Describe 'General Module Tests' {
    It 'Passes Test-ModuleManifest' {
        Test-ModuleManifest -Path $ModuleManifestName | Should Not BeNullOrEmpty
    }
    It 'Does Module Load' {
        {Import-Module .\DiscogsPS.psd1 -Force} | should not throw
    }
}

Import-Module .\DiscogsPS.psd1 -Force

Describe 'Objects are loading within the Module' {
    It 'DiscogsArtistMember Loads' {
        [DiscogsArtistMember]::new() | Should Not BeNullOrEmpty
    }
    It 'DiscogsImage Loads' {
        [DiscogsImage]::new() | Should Not BeNullOrEmpty
    }
    It 'DiscogsPaging Loads' {
        [DiscogsPaging]::new() | Should Not BeNullOrEmpty
    }
    It 'DiscogsArtist Loads' {
        [DiscogsArtist]::new() | Should Not BeNullOrEmpty
    }
}
