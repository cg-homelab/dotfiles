#!/bin/bash

print_colored() {
    printf "${1}%s${RC}\n" "$2"
}

setup_directories() {
    if [ ! -d "~/.config" ]; then
        print_colored "$YELLOW" "Creating .config/fish directory"
        mkdir -p ~/.config/fish
        print_colored "$GREEN" "Directory created"
    fi
}
install_pacman_dependencies() {
    if ! command_exists yay && ! command_exists paru; then
        printf "Installing yay as AUR helper...\n"
        ${SUDO_CMD} ${PACKAGER} --noconfirm -S base-devel
        cd /opt && ${SUDO_CMD} git clone https://aur.archlinux.org/yay-git.git && ${SUDO_CMD} chown -R "${USER}:${USER}" ./yay-git
        cd yay-git && makepkg --noconfirm -si
    else
        printf "AUR helper already installed\n"
    fi
    if command_exists yay; then
        AUR_HELPER="yay"
    elif command_exists paru; then
        AUR_HELPER="paru"
    else
        printf "No AUR helper found. Please install yay or paru.\n"
        exit 1
    fi
    ${AUR_HELPER} --noconfirm -S $1
}

install_dependancies() {
  print_colored "$YELLOW" "Installing dependencies..."
    if ! command_exists nvim; then
        DEPENDENCIES="${DEPENDENCIES} neovim"
    fi

    print_colored "$YELLOW" "Installing dependencies..."
    case "$PACKAGER" in
        pacman)
            install_pacman_dependencies $1
            ;;
        nala)
            ${SUDO_CMD} ${PACKAGER} install -y $1
            ;;
        brew)
            ${PACKAGER} install $1
            ;;
        zypper)
            ${SUDO_CMD} ${PACKAGER} install -n $1
            ;;
        *)
            ${SUDO_CMD} ${PACKAGER} install -yq $1
            ;;
    esac

    # install_fontbrew install "$1"
}
