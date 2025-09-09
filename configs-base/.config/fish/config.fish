
set -l os (uname)


### PATH/EXPORT ###
# Clear Path too avoid fish slowing down
set -e fish_user_paths

# Set theme
set --export THEME gruvbox
# set --export THEME catppuccin

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Dotnet Development
set --export ASPNETCORE_ENVIRONMENT Development
set --export ASPNETCORE_URLS "http://*:8080"

if test "$os" = Darwin
    # do things for macOS
    set -U fish_user_paths /Users/martin/.local/bin /Users/martin/.local.bin /Users/martin/.nix-profile/bin /Applications /opt/homebrew/bin /opt/homebrew/sbin /opt/homebrew/opt/libpq/bin /Users/martin/go/bin /Users/martin/.omnisharp/bin /Users/martin/.cargo/bin /Users/martin/.npm-global/bin
else if test "$os" = Linux
    # do things for Linux
    set -U fish_user_paths $HOME/.local/bin $HOME/.nix-profile/bin /nix/var/nix/profiles/default/bin $HOME/.cargo/bin $HOME/.cargo/bin $HOME/go/bin $HOME/.npm-global/bin $fish_user_paths
    if test "$HYPRSTARTED" = STARTED
        if test "$RANDOMBGRUNNING" = RUNNING
            set -Ux RANDOMBGRUNNING RUNNING
            hyprctl dispatch exec ~/.config/hypr/scripts/random-bg.sh
        end
    end
else
    # do things for other operating systems
end
### PATH END ###

### SET OPTIONS ###
# Check if env variable EZA_L_OPTIONS exists
if set -q EZA_L_OPTIONS
    # If it does, set the EZA_LL_OPTIONS variable
else
    # If it doesn't, setup eza
    emit fish-eza_install
end
# Supresses fish's intro message
set fish_greeting

#Set term color
set TERM xterm-256color

#Set default Editor
set EDITOR nvim

# Set manpager
set -x MANPAGER "nvim -c 'set ft=man'"
### SET OPTIONS END


set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"

### SET KEYBIND MODE ###
function fish_user_key_bindings
    #fish_default_key_bindings
    fish_vi_key_bindings
end
### SET KEYBIND MODE END ###


fastfetch
#pfetch
zoxide init fish | source
starship init fish | source

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
