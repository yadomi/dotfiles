setopt clobber
setopt alwaystoend

source ~/.zprezto/init.zsh

source ~/dotfiles/zsh/00-alias.sh
source ~/dotfiles/zsh/05-git.sh
source ~/dotfiles/zsh/10-variables.sh
source ~/dotfiles/zsh/private/99-private.sh

export GPG_TTY=$(tty)
