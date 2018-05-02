$ModuleName = 'DiscogsPS'

Import-Module platyPS
Import-Module $ModuleName -Force

New-MarkdownHelp -Module $ModuleName -OutputFolder .\docs
