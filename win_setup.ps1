#Requires -Version 7
<#
.SYNOPSIS
    The goal of this script is to install Git and Neovim using winget and then
    symlinking configs from my repository to the default location to configure
    neovim, powershell and WezTerm. Three apps that I use crossplatform.
.NOTES
  Version:        1.0
  Author:         Nick Owen nickolas.owen@protonmail.com
  Creation Date:  2025-03-13 15:09:23
  Purpose/Change: Initial script development
  
.EXAMPLE
  ./win_setup.ps1
#>

# Exit script unless running inside Windows
if(-not $IsWindows){
    Write-Host -ForegroundColor Red "`n    This script will only run under Windows. Exiting. `n"
    exit
}

# Elevate to Admin
if (-Not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Install Git [If not installed]
if (-not $(Get-Command "git" -ErrorAction SilentlyContinue)){
    winget install --id Git.Git -e --source winget
}

# Install Neovim [If not installed]
if (-not $(Get-Command "nvim" -ErrorAction SilentlyContinue)){
    winget install Neovim.Neovim
}

# Symlink Neovim Config
Invoke-Command {cmd.exe -C "mklink C:\Users\thema\AppData\Local\nvim C:\Users\thema\projects\github.com\me\dotfiles\.config\nvim"}

# Symlink Powershell Config
Invoke-Command {cmd.exe -C "mklink C:\Users\thema\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 C:\Users\thema\projects\github.com\me\dotfiles\Microsoft.PowerShell_profile.ps1"}

# Symlink WezTerm Config
Invoke-Command {cmd.exe -C "mklink C:\Users\thema\.wezterm.lua C:\Users\thema\projects\github.com\me\dotfiles\.wezterm.lua"}

