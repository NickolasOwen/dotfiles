## Remove alias for ls if it exists
$ls_alias = get-alias ls -ErrorAction SilentlyContinue
$ALACRITTY = "C:\Users\a_nowen1\AppData\Roaming\Alacritty\alacritty.toml"
$WEZTERM = "C:\Users\a_nowen1\.wezterm.lua"
if ($ls_alias){
  remove-item alias:ls
}
## Custom colors for ls to make output pretty
function ls() {
  param(
    [string]$path = $($(pwd).path)
  )
  get-childitem -force $path | %{
    if ($_.mode -like "d*") {
      write-host -ForegroundColor Magenta $_.name
    } else {
      write-host $_.name
    }
  }
}

function touch() {
  param(
    [string]$path = $($(pwd).path)
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

function pcd() {
  podman compose down
}

function ll() {
  param(
    [string]$path = $($(pwd).path)
  )
  get-childitem -force $path
}

# Change get-childitem directory colors to magenta
$PSStyle.FileInfo.Directory = "`e[35;1m"

Set-Alias -Name edit -Value nvim

Invoke-Expression (&starship init powershell)

$Env:PATH += ";C:\flutter\bin;C:\users\thema\.bin"
$Env:HXPROFILE = "C:\Users\thema\AppData\Roaming\helix\config.toml"

# Import Chocolatey Profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

