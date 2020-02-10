# DiscogsPS Module

Add a Description

Refernce Taglib sharp as a way to update files with media tags e.g. `ID3` for `.mp3` files

## Table of Contents



## Installation

Install from PowerShell gallery.

```powershell
Install-Module DiscogsPS
```

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
Import-Module PlatyPS
Import-Module .\DiscogsPS.psd1 -Force

Update-MarkdownHelp .\docs
```
---
## Project To Do

### Module Wide
1. [x] Roll URI arguments into a Generic Functions
2. [ ] Add More Commands
3. [ ] Add Examples to Readme.md
4. [ ] Write out the docs for each command
5. [ ] Add `[OutputType([<Type>])]` to all commands and create an output object for each command
6. [ ] Replace `New-Object` commands with the C++ tyle of creating new objects `[ObjectName]::new(Arguments)`.
7. [ ] Push to Github
8. [ ] Compile module functions into the psm1 file.
9. [ ] Store Token in `$script:Var` that is set after a user manually sets the script.
10. [ ] Add Help URI element to each cmdlet binding `HelpURI=<URI>` that send the user to a the Help XML files hosted somewhere, Probably Github

### Commands
- `Get-DiscogsPSArtistReleases`
    1. [x] Add Intelligent Error handeling as per API Docs
    2. [x] Implement Pagination for the Results of the API Call
- `Get-DiscogsPSArtist`
    1. [x] Add Intelligent Error handeling as per API Docs
- `Get-DiscogsPSRelease`
    1. [x] Add Intelligent Error handeling as per API Docs
    2. [x] Replace the switch statements and instead use a validate set attribute `[ValidateSet("Low", "Average", "High")]` [See here](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters?view=powershell-6#validateset-attribute)
    3. [ ] Implement a DiscogsRelease object to return
- `Search-DiscogsPSDatabase`
    1. [x] Add Intelligent Error handeling as per API Docs
    2. [x] Update this command to add URI Handling
    3. [ ] Check For Pagination and Get All Pages
- `Get-DiscogsPSReleaseRating`
    1. [x] Add Intelligent Error handeling as per API Docs
    1. [ ] Implement a DiscogsReleaseRating object and add pipeline input
- `Get-DiscogsPSMaster`
    1. [x] Add Intelligent Error handeling as per API Docs
    2. [ ] Implement a DiscogsMaster Objects and return this object


### Objects
- [ ] Move All objects to c# Class Lib
- `DiscogsMaster`
    1. [ ] Add Video Ref Object `DiscogsPSVideoStub`
    2. [ ] Add Artists Ref Object
    3. [x] Add Tracklist object `DiscogsTracklistItem`
- `DiscogsMasterStub`
    1. [ ] Add Constructor
- `DiscogsArtistStub`
    1. [ ] Add Constructor
- `DiscogsRelease`
    1. [ ] Basic Implementation of Class
    2. [ ] Add Label Ref Object
    3. [ ] Add Community Contribution Object
    4. [ ] Add Artist Ref Object
    5. [ ] Add Formats Object
    6. [ ] Add tracklist object (Could be same from `DiscogsPSMaster` need to check format)
    7. [ ] Add Identifers object
    8. [ ] Figure out JSON object defs for companies and series arrays and then implement them

### Implemented Objects
- `DiscogsPaging`
- `DiscogsTracklistItem`
    - `DiscogsTrackDuration`
- `DiscogsImage`
    - `DiscogsImageType` Enum
- `DiscogsArtist`
    - `DiscogsArtistMember`

---
## License

### MIT License
---

Copyright (c) 2018 Liam Townsend

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
