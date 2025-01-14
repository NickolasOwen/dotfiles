# Bash Aliases

# alias sways="sway -c ~/.config/sway/config"

alias ls='ls --color=auto'
alias gs='git status'
alias gd='git diff'
alias ga='git add -A'
alias gc='git commit -m'
alias gp='git pull'
alias gpu='git push'
alias gpd='git push -u origin dev'
alias gpm='git push -u origin main'
alias edit='nvim'
alias sedit='sudo /usr/bin/nvim'
alias batt='upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep percentage: | awk "{ print \$2 }"'
alias xquery='sudo xbps-query -Rs'
alias xinstall='sudo xbps-install -Su'
alias em='sudo emerge --ask'
alias emerge='sudo emerge --ask'
alias emu='sudo emerge --ask --changed-use --deep @world'
alias emd='sudo emerge --ask --depclean'
alias emr='sudo emerge --ask --deselect'
alias ems='sudo emerge --search'
# alias obsidian='obsidian --no-sandbox --ozone-platform=wayland --ozone-platform-hint=auto --enable-features=UseOzonePlatform,WaylandWindowDecorations %U'

alias pcs="podman compose ps"
alias pcb="podman compose build"
alias pcu="podman compose up -d"
alias pcd="podman compose down"

if command -v exa &> /dev/null; then
  alias ll='exa -la'
else
  alias ll='ls -ltrA'
fi

