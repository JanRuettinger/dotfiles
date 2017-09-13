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

" Run install script for YouCompleteMe if it was just installed
function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.sh
  endif
endfunction

Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM')}

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" code folding for python
Plug 'tmhedberg/SimpylFold'
Plug 'scrooloose/syntastic'
Plug 'alvan/vim-closetag'
 "Plug 'sheerun/vim-polyglot'
Plug 'easymotion/vim-easymotion'

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

" Python specific
" Python, PEP-008
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.py,*.pyw set textwidth=79
au BufRead,BufNewFile *.py,*.pyw set tabstop=4
au BufRead,BufNewFile *.py,*.pyw set softtabstop=4
au BufRead,BufNewFile *.py,*.pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set autoindent
au         BufNewFile *.py,*.pyw set fileformat=unix
au BufRead,BufNewFile *.py,*.pyw let b:comment_leader = '#'

" HTML/JS/CSS/SCSS specific
" HTML
au BufRead,BufNewFile *.html, *.scss, *.css  set filetype=xml
au BufRead,BufNewFile *.html, *.scss, *.css  set expandtab
au BufRead,BufNewFile *.html, *.scss, *.css  set tabstop=4
au BufRead,BufNewFile *.html, *.scss, *.css  set softtabstop=4
au BufRead,BufNewFile *.html, *.scss, *.css  set shiftwidth=4
au BufRead,BufNewFile *.html, *.scss, *.css  set autoindent
au         BufNewFile *.html set fileformat=unix
au BufRead,BufNewFile *.html let b:comment_leader = '<!--'

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

" YouCompleteMe plugin
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


" syntastic plugin
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_balloons = 0
let g:syntastic_error_symbol = '✗'
let g:syntastic_ignore_files = ['\.min\.js$', '\.min\.css$']
let g:syntastic_loc_list_height = 5
let g:syntastic_warning_symbol = '✗'
let g:syntastic_style_error_symbol = '∆'
let g:syntastic_style_warning_symbol = '∆'

let g:syntastic_html_checkers = []
let g:syntastic_javascript_checkers = ['standard']
let g:syntastic_json_checkers = ['jsonlint']
let g:syntastic_python_checkers = ['flake8']

" closetag plugin
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_close_shortcut = '<space>>'

" fzf
nnoremap <C-b> :Buffers<CR>
nnoremap <C-g> :Ag<CR>
nnoremap <C-p> :Files<CR>
nnoremap <C-l> :Lines<CR>
