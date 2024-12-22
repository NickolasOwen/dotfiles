# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# alias sways="sway -c ~/.config/sway/config"
alias ls='ls --color=auto'
if command -v exa &> /dev/null; then
  alias ll='exa -la'
else
  alias ll='ls -ltra'
fi
alias gs='git status'
alias gd='git diff'
alias ga='git add -A'
alias gc='git commit -m'
alias gp='git pull'
alias gpu='git push'
alias gpd='git push -u origin dev'
alias gpm='git push -u origin main'
alias edit='nvim'
alias sedit='doas /usr/bin/nvim'
alias batt='upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep percentage: | awk "{ print \$2 }"'
alias xquery='doas xbps-query -Rs'
alias xinstall='doas xbps-install -Su'
alias emerge='doas emerge'
alias emu='doas emerge --ask --changed-use --deep @world'
alias emd='doas emerge --ask --depclean'
alias emr='doas emerge --ask --deselect'

# pandoc projects/bitbucket.org/tti/howto/Monitoring/docs/ilmt.md | lynx --stdin
function mdlynx { pandoc $1 | lynx --stdin; }
export -f mdlynx

export PATH=$PATH:~/.local/bin:/home/linuxbrew/.linuxbrew/bin

# export XKB_DEFAULT_LAYOUT=us
# export XKB_DEFAULT_VARIANT=dvorak
# export XDG_RUNTIME_DIR=/tmp/swaytmp

export XDG_BACKEND=wayland
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_CACHE_HOME=/home/bear/.cache
export XDG_RUNTIME_DIR=/home/bear/.run/1000

export GTK_THEME=Adwaita:dark

# Makes manpages prettier
export PAGER="less"
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;33m'     # begin blink
export LESS_TERMCAP_so=$'\e[01;44;37m' # begin reverse video
export LESS_TERMCAP_us=$'\e[01;37m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
export MANPAGER='less -s -M +Gg'

# Initialize custom starship.rs prompt
# eval "$(starship init bash)"

# Source cargo for rust dev
# . "$HOME/.cargo/env"

# Source directory movement script
. "$HOME/.config/z.sh"

# Set Vi Mode
set -o vi

# Setup fzf (Fuzzy finding)
# eval "$(fzf --bash)"

# Create sway directory if it doesn't exist
# if [ ! -d /tmp/swaytmp ]; then
#   mkdir /tmp/swaytmp
# fi

# case $SH_CONNECTION in
#   '')
#     sways ;;
# esac

# if ! pgrep -x "sway" > /dev/null && ! -z "$SSH_CONNECTION"; then
#   sways
# fi
