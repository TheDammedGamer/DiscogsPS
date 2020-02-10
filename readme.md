# DiscogsPS Module

a WIP Module to interact with the Discogs API see here for the API docs [https://www.discogs.com/developers](https://www.discogs.com/developers)

Refernce Taglib sharp as a way to update files with media tags e.g. `ID3` for `.mp3` files

## Table of Contents
1. Installation
2. Examples
3. Help Files
4. Todo
5. Change Log


## Installation

Clone the Repository and Import the Module, Powershell Gallery to be set and added.
## Examples

### Example 1: Exmple Quick Name
```powershell
PS C:\> {{ Add example code here }}
PS C:\> {{ Add example code here }}
PS C:\> {{ Add example code here }}
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

### Example 2: Exmple Quick Name
```powershell
PS C:\> {{ Add example code here }}
PS C:\> {{ Add example code here }}
PS C:\> {{ Add example code here }}
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PowerShell Help Files
The help documents for this module are created using PlatyPS which converts markdown to PowerShell help files.

The documentation can be found in the `.\docs` folder.

If updating the help files please run the following commands to update the PowerShell help files aswell.

``` PowerShell
#If necessary istall the PlatyPs module
Install-Module PlatyPS
cd .\src\
Import-Module PlatyPS
Import-Module .\DiscogsPS.psd1 -Force

Update-MarkdownHelp .\docs
```

## [Project To Do](Todo.md)

## [Change Log](ChangeLog.md)


## License

Copyright (c) 2018 Liam Townsend

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
