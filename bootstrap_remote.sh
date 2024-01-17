readonly REPO_DIR="$HOME/.dotfiles/"
readonly PREFIX="\e[33m"

echo -e "${PREFIX}Running the main bootstrap..."

if ! pacman -Q -q git &> /dev/null; then
    echo -e "Couldn't find git. Installing git via \"pacman\"..."
    yes "" | pacman -S git &> /dev/null

    if ! yay -Q -q git &> /dev/null; then
        echo -e "Couldn't install git. Exiting..."
        exit 1
    fi
fi

if ! [ -d "$REPO_DIR" ]; then
    echo -e "${PREFIX}Cloning the \".dotfiles\" git repository..."
    git clone --recurse-submodules https://github.com/emresoysuren/.dotfiles.git \
        "$REPO_DIR" &> /dev/null

    if ! [ -d "$REPO_DIR" ]; then
        echo -e "${PREFIX}Couldn't clone the git repository. Exiting..."
        exit 1
    fi
fi

echo -e "${PREFIX}Running the \".dotfiles\" bootstrap script..."
if ! bash "$REPO_DIR/bootstrap.sh"; then
    echo -n -e "${PREFIX}Bootstrap has been failed. Exiting..."
    exit 1;
fi

echo -n -e "${PREFIX}Bootstrap has been completed. Do you want to reboot? (y/N) "
read yn
case $yn in
    [Yy]* ) systemctl reboot; break ;;
    * ) exit 0 ;;
esac
