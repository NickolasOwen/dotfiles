# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -ltra'
alias gs='git status'
alias gd='git diff'
alias ga='git add -A'
alias gc='git commit -m'
alias gp='git pull'
alias gpu='git push'
alias gpd='git push -u origin dev'
alias gpm='git push -u origin main'
alias edit='nvim'
alias sedit='sudo /home/nowen/.local/bin/nvim'
alias batt='upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep percentage: | awk "{ print \$2 }"'

alias xquery='sudo xbps-query -Rs'
alias xinstall='sudo xbps-install -Su'

# pandoc projects/bitbucket.org/tti/howto/Monitoring/docs/ilmt.md | lynx --stdin
function mdlynx { pandoc $1 | lynx --stdin; }
export -f mdlynx

export PATH=$PATH:~/.local/bin:/home/linuxbrew/.linuxbrew/bin

export XKB_DEFAULT_LAYOUT=us
export XKB_DEFAULT_VARIANT=dvorak
export XDG_RUNTIME_DIR=/tmp/swaytmp

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
eval "$(starship init bash)"

# Source cargo for rust dev
. "$HOME/.cargo/env"

# Source directory movement script
. "$HOME/.config/z.sh"
