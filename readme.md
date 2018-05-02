# ${PLASTER_PARAM_ModuleName} Module

Insert Descriptiom

## Installation

## Examples



## PowerShell Help Files
The help documents for this module are created using PlatyPS which converts markdown to PowerShell help files.

The Documentation can be found in the `.\docs` folder.

If updating the help files please run the following commands to update the PowerShell help files aswell.

``` PowerShell
#If necessary istall the PlatyPs module
Install-Module PlatyPS
Import-Module PlatyPS
Import-Module .\${PLASTER_PARAM_ModuleName}.psd1 -Force

Update-MarkdownHelp .\docs
```

## To Do


# License


### MIT License

Copyright (c) 2018 Liam Townsend

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
