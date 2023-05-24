# PowerShell

## [Installing PowerShell on macOS](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-macos?view=powershell-7.3) 

## Paths (MacOS)
* $PSHOME is `/usr/local/microsoft/powershell/<version number>/`
* User profiles are read from `~/.config/powershell/profile.ps1`
* Default profiles are read from `$PSHOME/profile.ps1`
* User modules are read from `~/.local/share/powershell/Modules`
* Shared modules are read from `/usr/local/share/powershell/Modules`
* Default modules are read from `$PSHOME/Modules`
* PSReadLine history are recorded to `~/.local/share/powershell/PSReadLine/ConsoleHost_history.txt`

## PROFILE

- [MS Document](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-7.3)
- The $PSHOME variable stores the installation directory for PowerShell
- The $HOME variable stores the current user's home directory

* All Users, All Hosts
  * Windows - $PSHOME\Profile.ps1
  * Linux - /usr/local/microsoft/powershell/7/profile.ps1
  * macOS - /usr/local/microsoft/powershell/7/profile.ps1
* All Users, Current Host
  * Windows - $PSHOME\Microsoft.PowerShell_profile.ps1
  * Linux - /usr/local/microsoft/powershell/7/Microsoft.Powershell_profile.ps1
  * macOS - /usr/local/microsoft/powershell/7/Microsoft.Powershell_profile.ps1
* Current User, All Hosts
  * Windows - $HOME\Documents\PowerShell\Profile.ps1
  * Linux - ~/.config/powershell/profile.ps1
  * macOS - ~/.config/powershell/profile.ps1
* Current user, Current Host
  * Windows - $HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
  * Linux - ~/.config/powershell/Microsoft.Powershell_profile.ps1
  * macOS - ~/.config/powershell/Microsoft.Powershell_profile.ps1


## Prompt

```bash
  $ Get-Command Promt
  $ (Get-Command Prompt).ScriptBlock # ScriptBlock

```
