# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Import Alias
if [ -f "$HOME/.bash_aliases" ]; then
  source "$HOME/.bash_aliases"
fi

function pcbr {
  PCS=$(podman compose ps)
  if [ $PCS ]; then
    podman compose down
  fi
  podman compose build
  podman compose up -d
}
export -f pcbr

# pandoc projects/bitbucket.org/tti/howto/Monitoring/docs/ilmt.md | lynx --stdin
function mdlynx { pandoc $1 | lynx --stdin; }
export -f mdlynx

# export PATH=$PATH:~/.local/bin:/home/linuxbrew/.linuxbrew/bin

export XKB_DEFAULT_LAYOUT=us
export XKB_DEFAULT_VARIANT=dvorak
# export XDG_RUNTIME_DIR=/tmp/swaytmp

# export NPM_CONFIG_PREFIX=$HOME/.local/
export PATH="/home/$USER/go/bin:/home/$USER/.local/bin:$NPM_CONFIG_PREFIX/bin:~/.local/bin:/home/linuxbrew/.linuxbrew/bin:$PATH"
export PATH="~/.local/flutter/bin:$PATH"

# export XDG_BACKEND=wayland
# export XDG_SESSION_TYPE=wayland
# export XDG_CURRENT_DESKTOP=Hyprland
# export XDG_CACHE_HOME=/home/bear/.cache
# export XDG_RUNTIME_DIR=/home/bear/.run/1000

export PODMAN_COMPOSE_WARNING_LOGS=false
export NVM_DIR="$HOME/.nvm"

export GTK_THEME=Adwaita:dark
# export CHROME_EXECUTABLE="google-chrome-stable --enable-features=VaapiVideoDecodeLinuxGL --use-gl=angle --use-angle=gl --ozone-platform=wayland"
# export CHROME_EXECUTABLE="google-chrome-stable"

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

export PS1="\[\e[33m\]\u\[\e[m\]@\[\e[36m\]\h\[\e[m\] \[\e[35m\]\w\[\e[m\]\[\e[33m\]:\[\e[m\] "

# Source cargo for rust dev
. "$HOME/.cargo/env"

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
# cd ~/

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
