# Coreutils binaries for macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
fi

# Export some binaries that could be in ~/.bin
export PATH=$PATH:"$HOME/.bin/"

