# Dotfiles

## Install

```sh
git clone https://github.com/JanRuettinger/dotfiles.git 
sh dotfiles/Linux/install.sh
```

## Included tools

### tldr
Get an overview of the most common flags for a command.
```
tldr <command>
```

### zsh
Better shell compared to bash

### oh-my-zsh
Oh-my-zsh is a framework to manage your zsh configugration. It allows you to easily install plugins and themes.

#### plugins
autosuggestion: suggests commands as you type based on your history.
syntax highlighting: highlights commands in the zsh prompt
z: jump quickly to directories you visit frequently `z <partial string>`
fzf: fuzzy search in zsh prompt `<Ctrl-r>`

#### theme
Nord theme

The nord theme requires you to install a font with more symbols on iterm, e.g. [Hack Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack)

### bat
cat but with syntax highlighting

### htop
Terminal based activity monitor

### tmux
Tmux is a terminal multiplexer for Unix-like operating systems. It allows multiple terminal sessions to be accessed simultaneously in a single window. It is useful for running more than one command-line program at the same time. 

Most helpful commands:
```sh
tmux new -s <name>
tmux ls
tmux a -t <name>
```

### tree
Tree allows you to list content of a directly in a tree like format

### ncdu
Ncdu is a disk usage analyzer

### tig
Tig is an ncurses-based text-mode interface for git

### fd
fd is a program to find entries in your filesystem

### exa
exa is a replacement for `ls` with better defaults and more highlighting 

### ripgrep
ripgrep is a fast command line code search tool