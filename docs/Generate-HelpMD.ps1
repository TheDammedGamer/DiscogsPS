$ModuleName = 'DiscogsPS'


Import-Module $ModuleName -Force
Import-Module platyPS

New-MarkdownHelp -Module $ModuleName -OutputFolder .\docs
