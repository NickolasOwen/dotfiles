if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias ls="ls --color=auto"
alias ll="ls -ltrA"

alias gs="git status"
alias ga="git add -A"
alias gc="git commit -m"
alias gp="git pull"
alias gpu="git push"
alias gd="git diff"

alias edit="nvim"
alias sedit="sudo nvim"

alias xinstall="sudo xbps-install -Su"
alias xquery="sudo xbps-query -Rs"

alias pcs="podman compose ps"
alias pcb="podman compose build"
alias pcu="podman compose up -d"
alias pcd="podman compose down"

