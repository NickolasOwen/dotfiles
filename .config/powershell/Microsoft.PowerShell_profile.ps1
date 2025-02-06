# Set variables to edit configs easily for NVIM and WezTerm on linux and windows
if ($IsWindows) {
    $WEZTERM = "C:\Users\bear\projects\bitbucket.org\me\dotfiles\.wezterm.lua"
    $NVIMCONFIG = "C:\Users\bear\projects\bitbucket.org\me\dotfiles\.config\nvim\init.lua"
} elseif ($IsLinux) {
    $WEZTERM = "~/.dotfiles/.wezterm.lua"
    $NVIMCONFIG = "~/.dotfiles/.config/nvim/init.lua"
} elseif ($IsMacOS) {
    $Env:PATH += ":/usr/local/bin/:~/.cargo/bin/"
    $WEZTERM = "~/.dotfiles/.wezterm.lua"
    $NVIMCONFIG = "~/.dotfiles/.config/nvim/init.lua"
}

## Remove alias for ls if it exists
$ls_alias = get-alias ls -ErrorAction SilentlyContinue
if ($ls_alias){
    remove-item alias:ls
}

# Create ll shortcut to mimic Bash ls -ltrA
function ll() {
    param(
        [string]$path = $($(Get-Location).path)
    )
    get-childitem -force $path
}

# Change get-childitem directory colors to magenta
$PSStyle.FileInfo.Directory = "`e[35;1m"

## Custom colors for ls to make output pretty
function ls() {
    param(
        [string]$path = $($(Get-Location).path)
    )
    get-childitem -force $path | ForEach-Object {
        $fileName = $_.name
        # Set color of directories
        if ($_.mode -like "d*") {
            write-host -ForegroundColor Magenta $fileName
        # Set color of symlinks
        } elseif ($_.mode -like "l*") {
            write-host -ForegroundColor DarkBlue $fileName -NoNewline
            write-host -ForegroundColor Yellow " -> " -NoNewline
            write-host -ForegroundColor DarkRed $_.LinkTarget
        } else {
            write-host $fileName
        }
    }
}

function touch() {
    param(
        [string]$path = $($(Get-Location).path)
    )
    out-file $path
}

function gs() {
    git status
}

function gb() {
    git branch
}

function ga() {
    git add -A
}

$gcAlias = get-alias gc -erroraction SilentlyContinue
if ($gcAlias) {
    $gcAlias | remove-alias -force
}

function gc() {
    param(
        [string]$message
    )
    git commit -m $message
}

$gpAlias = get-alias gp -erroraction SilentlyContinue
if ($gpAlias) {
    $gpAlias | remove-alias -force
}

function gp() {
    git pull
}

function gpu() {
    $branch = git rev-parse --abbrev-ref HEAD
    git push -u origin $branch
}

function gd() {
    git diff
}

function pcs() {
    podman compose ps
}

function pcb() {
    podman compose build
}

## Build and (re)launch podman containers
function pcbr() {
    if ($(podman compose ps)) {
        podman compose down
    }
    podman compose build
    podman compose up -d
}

function pcu() {
    podman compose up -d
}
function pcb() {
    podman compose build
}
function pcd() {
    podman compose down
}
function pcp() {
  podman compose pull
}

Set-Alias -Name edit -Value nvim

function xinstall() {
    param(
        [string]$app
    )
    if ($app) {
        sudo xbps-install -Su $app
    } else {
        sudo xbps-install -Su
    }
}

function xquery() {
    param(
        [string]$app
    )
    sudo xbps-query -Rs $app
}

function batt() {
    upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep percentage: | awk "{ print $2 }"
}

# Invoke-Expression (&starship init powershell)

# $Env:PATH += ";C:\flutter\bin;C:\users\thema\.bin"
# $Env:HXPROFILE = "C:\Users\thema\AppData\Roaming\helix\config.toml"

# Import Chocolatey Profile
# $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
# if (Test-Path($ChocolateyProfile)) {
#   Import-Module "$ChocolateyProfile"
# }

$modules = Get-ChildItem -Recurse -File -Filter "*.psm1" -Path "~/projects"
foreach ($module in $modules) {
  if ($module.FullName -like "*vscode*" -or $module.FullName -like "*nvim*") {continue}
    try {
        Import-Module $module.FullName
        Write-Host "Imported" $module.FullName
    }
    catch {Write-Host "Unable to import" $module.FullName}
}

# Attemp at prompt
# function prompt {
#   $p = $executionContext.SessionState.Path.CurrentLocation
#   $osc7 = ""
#   if ($p.Provider.Name -eq "FileSystem") {
#     $ansi_escape = [char]27
#     $provider_path = $p.ProviderPath -Replace "\\", "/"
#     $osc7 = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}${ansi_escape}\"
#   }
#   "${osc7}PS $p$('>' * ($nestedPromptLevel + 1)) ";
# }

# Nick's Custom Prompt
function prompt {
  $p = $executionContext.SessionState.Path.CurrentLocation
  $osc7 = ""
  if ($p.Provider.Name -eq "FileSystem") {
    $ansi_escape = [char]27
    $provider_path = $p.ProviderPath -Replace "\\", "/"
    $osc7 = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}${ansi_escape}\"
  }
    if ($IsWindows) {
        $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
        $principal = [Security.Principal.WindowsPrincipal] $identity
        $adminRole = [Security.Principal.WindowsBuiltInRole]::Administrator

        $elevate = $(
            if (Test-Path variable:/PSDebugContext) { '[DBG]: ' }
            elseif($principal.IsInRole($adminRole)) { "[ADMIN]: " }
            else { '' }
        )
    }

    $hostname = $([System.Net.Dns]::GetHostName()).ToLower()
    if ($hostname -like "*mac*") {
        $hostname = "mac"
    }

    $currentDir = $(''+$pwd).replace($HOME, '~')

    if ($IsWindows) {
        $username = $($Env:USERNAME).ToLower()
    } else {
        $username = $($Env:USER).ToLower()
    }
    $prompt = "${osc7}$([char]0x1b)[91m$($elevate)$([char]0x1b)[0m$([char]0x1b)[1;33m$($username)$([char]0x1b)[0m$("@")$([char]0x1b)[1;96m$($hostname)$([char]0x1b)[0m $([char]0x1b)[35m$($currentDir)$([char]0x1b)[0m$([char]0x1b)[33m$(":")$([char]0x1b)[0m "
    return $prompt
}

