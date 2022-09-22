# Coreutils binaries for macOS
if [[ "$(uname)" == "Darwin" ]]; then
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
fi;

# Export some binaries that could be in ~/.bin
export PATH="$HOME/.bin/:$PATH"
export PATH="$HOME/Library/Python/3.8/bin:$PATH"
export PATH=/opt/homebrew/bin:$PATH

# Deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Others
export GUILE_TLS_CERTIFICATE_DIRECTORY=/opt/homebrew/etc/gnutls/
export GPG_TTY=$(tty)
export EDITOR=vim
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
