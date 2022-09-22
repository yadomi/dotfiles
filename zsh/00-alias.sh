alias ls='ls --color=auto'
alias lso="ls -alG | awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\" %0o \",k);print}'"

alias fuck='sudo $(fc -ln -1)'
alias ip='curl -s https://api.ipify.org?format=json | jq -cr .ip'

alias qr='qrcode-terminal'
alias docker-rmi='docker rmi -f $(docker images -q -f "dangling=true")'
alias rmnodemodules='find . -type d -name "node_modules" -exec rm -rf {} \;'

explain () {
   open "https://explainshell.com/explain?cmd=$(echo $@ | tr " " +)"
}
