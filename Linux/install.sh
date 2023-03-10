# Check if program exists
function program_exists() {
    local ret='0'
    command -v $1 >/dev/null 2>&1 || { local ret='1'; }

    # fail on non-zero return value.
    if [ "$ret" -ne 0 ]; then
        echo "`$1` is not installed" 
        return 1
    fi

    return 0
}

# Assert the special programs must exist.
function program_must_exist() {
    program_exists $1

    # throw error on non-zero return value
    if [ "$?" -ne 0 ]; then
        echo "You must have '$1' installed to continue."
        exit 1
    fi
}


# Install python packages by pip.
function pip_install {
    program_must_exist "pip"

    echo "start to instlal tldr."
    program_exists "tldr" || pip install tldr --user
}

# Install packages by apt-get(For Debian/Ubuntu-based distributions)
function apt_get_install() {
    sudo apt-get update
    apt_get_install_dependency

    echo "start to install git"
    program_exists "git" || sudo apt-get install git -y

    echo "start to install pip"
    program_exists "pip" || sudo apt-get install python3-pip -y

    echo "start to install curl"
    program_exists "curl" || sudo apt-get install curl -y

    echo "start to install htop"
    program_exists "htop" || sudo apt-get install htop -y

    echo "start to install zsh"
    program_exists "zsh" || sudo apt-get install zsh -y

    echo "change default shell to zsh"
    program_must_exist zsh || sudo chsh -s /bin/zsh

    echo "install oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    echo "install noh my zsh nord theme"
    git clone https://github.com/fxbrit/nord-extended $HOME/.oh-my-zsh/themes/nord-extended

    echo "start to install fzf"
    program_exists "fzf" || sudo apt-get install -y fzf

    echo "start to install tmux"
    program_exists "tmux" || sudo apt-get install -y tmux

    echo "start to install ncdu"
    program_exists "ncdu" || sudo apt-get install ncdu -y

    echo "start to install vim"
    program_exists "vim" || sudo apt-get install vim -y

    echo "start to install tree"
    program_exists "tree" || sudo apt-get install tree -y
}


# function install_awesome_tools() {
#     if [ "$(uname)" == "Darwin" ]; then
# 	# Do something under Mac OS X platform
# 	echo "This is mac os"
# 	# check if brew exists
# 	brew_install
#     elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
# 	# Do something under GNU/Linux platform
# 	if type apt-get >/dev/null 2>&1; then
# 	    apt_get_install
# 	elif type yum >/dev/null 2>&1; then
# 	    yum_dnf_install
# 	elif type pacman >/dev/null 2>&1; then
# 	    pacman_install
# 	fi
# }

# # Start to install all awesome tools
# install_awesome_tools

apt_get_install
pip_install


#==============
# Variables
#==============
dotfiles_dir=~/dotfiles


#==============
# Delete existing dot files and folders
#==============
sudo rm -rf ~/.vim > /dev/null 2>&1
sudo rm -rf ~/.vimrc > /dev/null 2>&1
sudo rm -rf ~/.tmux > /dev/null 2>&1
sudo rm -rf ~/.tmux.conf > /dev/null 2>&1
sudo rm -rf ~/.zshrc > /dev/null 2>&1
sudo rm -rf ~/.gitconfig > /dev/null 2>&1

ln -sf $dotfiles_dir/vim ~/.vim
ln -sf $dotfiles_dir/vimrc ~/.vimrc
ln -sf $dotfiles_dir/gitconfig ~/.gitconfig
ln -sf $dotfiles_dir/tmux.conf ~/.tmux.conf
ln -sf $dotfiles_dir/zshrc ~/.zshrc
ln -sf $dotfiles_dir/zshrc.pre-oh-my-zsh ~/.zshrc.pre-oh-my-zsh


echo "Finished"