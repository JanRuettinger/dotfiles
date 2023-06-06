# Check if program exists
function program_exists() {
    local ret='0'
    command -v $1 >/dev/null 2>&1 || { local ret='1'; }

    # fail on non-zero return value.
    if [ "$ret" -ne 0 ]; then
        echo "$1 is not installed" 
        return 1
    fi

    echo "$1 is already installed"

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


# Install packages by apt-get(For Debian/Ubuntu-based distributions)
function install_programs() {
    # install brew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    echo "start to install git"
    program_exists "git" || brew install git

    # echo "start to install pip"
    # program_exists "pip" || sudo apt-get install python3-pip -y

    # echo "start to install curl"
    # program_exists "curl" || sudo apt-get install curl -y

    echo "start to install htop"
    program_exists "htop" || brew install htop

    echo "start to install zsh"
    program_exists "zsh" || brew install zsh

    echo "install oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    echo "install oh-my-zsh autosuggestion plugin"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

    echo "install oh-my-zsh syntax highlighting plugin"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

    echo "install oh my zsh nord theme"
    git clone https://github.com/fxbrit/nord-extended $HOME/.oh-my-zsh/themes/nord-extended

    echo "start to instlal tldr."
    pip install tldr --user

    echo "start to install fzf"
    program_exists "fzf" || brew install fzf

    echo "start to install tmux"
    program_exists "tmux" || brew install tmux

    echo "start to install ncdu"
    program_exists "ncdu" || brew install ncdu

    echo "start to install vim"
    program_exists "vim" || brew install vim

    echo "start to install tree"
    program_exists "tree" || brew install tree

    echo "start to install tig"
    program_exists "tig" || brew install tig

    echo "start to install fd"
    program_exists "fd" || brew install fd

    echo "start to install ripgrep"
    program_exists "ripgrep" || brew install ripgrep

    echo "start to install exa"
    program_exists "exa" || brew install exa

    echo "start to install bat"
    program_exists "bat" || brew install bat && mkdir -p ~/.local/bin && ln -s /usr/bin/batcat ~/.local/bin/bat 
}


#==============
# Variables
#==============
dotfiles_dir=~/dotfiles
backup_dir=~/backup-dotfiles-`(date +'%m_%d_%Y_%H_%M')`

#==============
# Create backup of existing dotfiles
#==============
mkdir $backup_dir

cp -r ~/.vim $backup_dir
cp ~/.vimrc $backup_dir
cp -r ~/.oh-my-zsh $backup_dir
cp ~/.tmux.conf $backup_dir
cp ~/.zshrc $backup_dir
cp ~/.gitconfig $backup_dir


#==============
# Delete existing dot files and folders
#==============
sudo rm -rf ~/.vim > /dev/null 2>&1
sudo rm -rf ~/.vimrc > /dev/null 2>&1
# sudo rm -rf ~/.tmux > /dev/null 2>&1
sudo rm -rf ~/.oh-my-zsh > /dev/null 2>&1
sudo rm -rf ~/.tmux.conf > /dev/null 2>&1
sudo rm -rf ~/.zshrc > /dev/null 2>&1
sudo rm -r ~/.zshrc.pre-oh-my-zsh > /dev/null 2>&1
sudo rm -rf ~/.gitconfig > /dev/null 2>&1
sudo rm -r ~/.local/bin/bat > /dev/null 2>&1

install_programs

cp -r $dotfiles_dir/vim ~/.vim
ln -sf $dotfiles_dir/vimrc ~/.vimrc
ln -sf $dotfiles_dir/gitconfig ~/.gitconfig
ln -sf $dotfiles_dir/tmux.conf ~/.tmux.conf
ln -sf $dotfiles_dir/zshrc ~/.zshrc
ln -sf $dotfiles_dir/zshrc.pre-oh-my-zsh ~/.zshrc.pre-oh-my-zsh

echo "change default shell to zsh"
sudo chsh -s /bin/zsh
exec zsh

echo "Finished"