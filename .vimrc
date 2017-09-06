set nocompatible
filetype plugin indent on    " required

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.sh
  endif
endfunction
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

Plug 'scrooloose/syntastic' 

Plug 'kien/ctrlp.vim'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
call plug#end()

" Leader key
let mapleader=","
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <leader>sv :so $MYVIMRC<CR>

set hidden " hides buffers instead of closing them => Open a new file without being forced to write or undo changed of current file first.
" Colors

colorscheme badwolf	" awesome colorscheme
syntax enable 		" enable syntax processing


" UI Config
set tabstop=4   " a tab is four spaces
set autoindent
set copyindent
set shiftwidth=4
set shiftround
set number		" show line numbers
set showcmd		" show command in bottom bar
set cursorline		" highlight current line
set wildmenu		" visual autocomplete for command menu
set showmatch		" highlight matching [{()}]
set incsearch		" search as characters are entered
set hlsearch		" highlight matches
set backspace=indent, eol " use backspace to delete text past the start of the insert operation
set tags=tags;/
nnoremap <leader><space> :nohlsearch<CR> 	"turn off search highlight
nnoremap gV `[v`]	" highlight last inserted text

" Leader Shortcuts
inoremap jj <esc> 	" jj is escape

" Backups
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" Open new buffers
nmap <leader>s<left>   :leftabove  vnew<cr>
nmap <leader>s<right>  :rightbelow vnew<cr>
nmap <leader>s<up>     :leftabove  new<cr>
nmap <leader>s<down>   :rightbelow new<cr>

" Tab between buffers
noremap <tab> <c-w><c-w>

" Switch between last two buffers
nnoremap <leader><leader> <C-^>

" Resize buffers
if bufwinnr(1)
  nmap Ä <C-W><<C-W><
  nmap Ö <C-W>><C-W>>
  nmap ö <C-W>-<C-W>-
  nmap ä <C-W>+<C-W>+
endif
" Plugins
"set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/

" Always show statusline
set laststatus=2

" syntastic

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

set cpoptions+=$
set colorcolumn=80
nnoremap <Leader>b :ls<CR>:b<Space>
inoremap <Leader>rn argdel * <bar> :bufdo argadd % <bar> :%bd <bar> :argdo e
set pastetoggle=<F2> " press before paste large text
nmap <leader>w :w!<cr>
