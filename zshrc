export LC_ALL=fr_FR.UTF-8
export LANG=fr_FR.UTF-8

# ---
# Default & Behavior
# ---
autoload -U compinit
autoload -Uz vcs_info
autoload -U colors && colors
compinit

setopt clobber
setopt alwaystoend
setopt auto_cd                          # Auto changes to a directory without typing cd.
setopt auto_pushd                       # Push the old directory onto the stack on cd.
setopt pushd_ignore_dups                # Do not store duplicates in the stack.
setopt pushd_silent                     # Do not print the directory stack after pushd or popd.
setopt pushd_to_home                    # Push to home directory when no argument is given.
setopt cdable_vars                      # Change directory to a path stored in a variable.
setopt multios                          # Write to multiple descriptors.
setopt extended_glob                    # Use extended globbing syntax.


# ---
# History
# ---
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt bang_hist                        # Treat the '!' character specially during expansion.
setopt extended_history                 # Write the history file in the ":start:elapsed;command" format.
setopt inc_append_history               # Write to the history file immediately, not when the shell exits.
setopt share_history                    # Share history between all sessions.
setopt hist_expire_dups_first           # Expire duplicate entries first when trimming history.
setopt hist_ignore_dups                 # Don't record an entry that was just recorded again.
setopt hist_ignore_all_dups             # Delete old recorded entry if new entry is a duplicate.
setopt hist_find_no_dups                # Do not display a line previously found.
setopt hist_ignore_space                # Don't record an entry starting with a space.
setopt hist_save_no_dups                # Don't write duplicate entries in the history file.
setopt hist_reduce_blanks               # Remove superfluous blanks before recording entry.
setopt hist_verify                      # Don't execute immediately upon history expansion.

# Fish style history substring search
source ~/dotfiles/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down


# ---
# Editor key binding
# ---
bindkey  "^[[H"   beginning-of-line     # Home key
bindkey  "^[[F"   end-of-line           # End key
bindkey  "^[[3~"  delete-char           # Delete key


# ---
# Autocompletion
# ---
setopt complete_in_word                 # Complete from both ends of a word.
setopt always_to_end                    # Move cursor to the end of a completed word.
setopt path_dirs                        # Perform path search even on command names with slashes.
setopt auto_menu                        # Show completion menu on a successive tab press.
setopt auto_list                        # Automatically list choices on ambiguous completion.
setopt auto_param_slash                 # If completed parameter is a directory, add a trailing slash.
unsetopt menu_complete                  # Do not autoselect the first completion entry.
unsetopt flow_control                   # Disable start/stop characters in shell editor.

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Group matches and describe.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes

# Fuzzy match mistyped completions.
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Directories
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true


# ---
# Prompt
# ---
setopt prompt_subst

precmd() { vcs_info }

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{yellow} ●%f'
zstyle ':vcs_info:*' unstagedstr '%F{red} ✖%f'
zstyle ':vcs_info:*' formats '%F{pink}(%b)%%f%u%c%F{cyan}%m%f '

zstyle ':vcs_info:git*+set-message:*' hooks git-st

function +vi-git-st() {
    local ahead behind
    local -a gitstatus

    # Exit early in case the worktree is on a detached HEAD
    git rev-parse ${hook_com[branch]}@{upstream} >/dev/null 2>&1 || return 0

    local -a ahead_and_behind=(
        $(git rev-list --left-right --count HEAD...${hook_com[branch]}@{upstream} 2>/dev/null)
    )

    ahead=${ahead_and_behind[1]}
    behind=${ahead_and_behind[2]}

    (( $ahead )) && gitstatus+=( " ↑${ahead}" )
    (( $behind )) && gitstatus+=( " ↓${behind}" )

    hook_com[misc]+=${(j::)gitstatus}
}

PS1='%{%F{yellow}%}%1~%{%f%} ${vcs_info_msg_0_}$: '

# ---
# Extra stuffs
# ---
source ~/dotfiles/zsh/00-alias.sh
source ~/dotfiles/zsh/05-git.sh
source ~/dotfiles/zsh/10-variables.sh
source ~/dotfiles/zsh/private/99-private.sh
