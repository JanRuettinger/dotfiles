if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if empty(glob('~/.vim/colors/badwolf.vim'))
  silent !curl -fLo ~/.vim/colors/badwolf.vim --create-dirs
    \ https://raw.githubusercontent.com/JanRuettinger/dotfiles/master/vim/colors/badwolf.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" code folding for python
Plug 'tmhedberg/SimpylFold'
Plug 'alvan/vim-closetag'
Plug 'easymotion/vim-easymotion'

" code linter and fixer
Plug 'w0rp/ale'

call plug#end()

" Leader key
let mapleader=","
inoremap jj <esc>   " jj is escape

" Colors and Syntax
colorscheme badwolf " awesome colorscheme
syntax enable     " enable syntax processing
let python_highlight_all=1

" new split window below and right
set splitbelow
set splitright

"split navigations
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

"Open new splits
nmap <tab><left>   :leftabove  vnew<cr>
nmap <tab><right>  :rightbelow vnew<cr>
nmap <tab><up>     :leftabove  new<cr>
nmap <tab><down>   :rightbelow new<cr>

" buffers
" Switch between
nnoremap <leader><tab> <C-^>
" Search and open
nnoremap <Leader>b :ls<CR>:b<Space>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" Open a new file without being forced to write or undo changed of current file first.
set hidden

" General UI stuff
set number		" show line numbers
set showcmd		" show command in bottom bar
set cursorline		" highlight current line
set wildmenu		" visual autocomplete for command menu
set showmatch		" highlight matching [{()}]
set incsearch		" search as characters are entered
set hlsearch		" highlight matches
set backspace=indent, eol " use backspace to delete text past the start of the insert operation
set colorcolumn=80
" Always show statusline
set laststatus=2
nnoremap <leader><space> :nohlsearch<CR> 	"turn off search highlight
nnoremap gV `[v`]	" highlight last inserted text


" Backups
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup


" Resize splits
if bufwinnr(1)
  map = <C-W>+
  map - <C-W>-
endif

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" closetag plugin
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_close_shortcut = '<space>>'

" fzf
nnoremap <C-b> :Buffers<CR>
"nnoremap <C-g> :Ag<CR>
nnoremap <C-p> :Files<CR>
" nnoremap <C-l> :Lines<CR>

" ale fixer and linter settings
let g:ale_linters = {'python': ['autopep8']}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['autopep8'],
\}
" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1
" Enable completion where available.
let g:ale_completion_enabled = 1
