eval "$(starship init zsh)"
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
export PGHOST="/var/run/postgresql"

export PATH=$PATH:/usr/local/go/bin


HISTFILE=~/.history
HISTSIZE=10000
SAVEHIST=50000


iatest=$(expr index "$-" i)

#######################################################
# SOURCED ALIASES AND SCRIPTS BY zachbrowne.me
#######################################################
if command -v fastfetch &> /dev/null; then
    # Only run fastfetch if we're in an interactive shell
    if [[ $- == *i* ]]; then
        fastfetch
    fi
fi

setopt inc_append_history

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"

# . "$HOME/.asdf/asdf.sh"

# append completions to fpath
# fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
# autoload -Uz compinit && compinit


## Nix
# Add any additional configurations here
export PATH=$HOME/.nix-profile/bin:/run/current-system/sw/bin:$PATH
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi



[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

