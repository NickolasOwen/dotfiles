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

# Install Yazi and Optional Dependencies
if (-not $(Get-Command "yazi" -ErrorAction SilentlyContinue)){
    winget install sxyazi.yazi
    # Install the optional dependencies (recommended):
    winget install Gyan.FFmpeg 7zip.7zip jqlang.jq sharkdp.fd BurntSushi.ripgrep.MSVC junegunn.fzf ajeetdsouza.zoxide ImageMagick.ImageMagick
}

# Symlink Neovim Config
New-Item -ItemType SymbolicLink -Path "C:\Users\thema\AppData\Local\nvim" -Target "C:\Users\thema\projects\github.com\me\dotfiles\.config\nvim"

# Symlink Powershell Config
New-Item -ItemType SymbolicLink -Path "C:\Users\thema\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -Target "C:\Users\thema\projects\github.com\me\dotfiles\Microsoft.PowerShell_profile.ps1"

# Symlink WezTerm Config
New-Item -ItemType SymbolicLink -Path "C:\Users\thema\.wezterm.lua" -Target "C:\Users\thema\projects\github.com\me\dotfiles\.wezterm.lua"

