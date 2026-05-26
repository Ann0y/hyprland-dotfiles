# PATH
export PATH="$HOME/.local/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
# export EDITOR='nvim'
# export LIBVA_DRIVER_NAME=iHD
# export LIBVA_DRIVER_PATH=/usr/lib/dri

#plugins 

plugins=(git)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/oh-my-zsh.sh

 #starship
  eval "$(starship init zsh)"

# genernal alias

  alias c="clear"
  alias e="exit"
  alias open='xdg-open'
  alias ll="ls -l"
  alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
  alias update-kernel='sudo mkinitcpio -P'
  alias y='yazi'
# pacman & yay

  alias pcs="sudo pacman -S"
  alias pcss="sudo pacman -Ss"
  alias pcu="sudo pacman -Syu"
  alias pcqs="pacman -Qs"
  alias pcrns="sudo pacman -Rns"
  alias pcrnsq='sudo pacman -Rns $(pacman -Qdtq)'
  alias pcc="sudo pacman -Sc"
  alias pccc="sudo pacman -Scc"
  alias yu="yay -Syu"
  alias ys="yay -S"
  alias yss="yay -Ss"
  alias pcql='pacman -Ql'
  alias v="nvim"
  alias ff="fastfetch"
  alias ts="tmux new -s"
  
# nvm-node manager package

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# customize function

function k(){
  cd ~/Downloads/kernel/
}
function d(){
  cd ~/Downloads/
}
function s(){
  cd ~/study/
}
function p(){
  cd ~/Projects/
}


# pnpm
export PNPM_HOME="/home/annoy/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
