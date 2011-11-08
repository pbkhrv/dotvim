" remove compatibility with vi
set nocompatible

set modelines=0

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
" set undofile

let mapleader = ","

set wrap
set formatoptions=qrn1

" same invisible chars as TextMate
" set list
" set listchars=tab:▸\ ,eol:¬

" use F1 key as ESC!!!
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" use semicolon as colon 
nnoremap ; :

" use Ack via ,a
nnoremap <leader>a :Ack

" use ,v to reselect the text that was just pasted
nnoremap <leader>v V`]

" ,w for open new vertical split and switch to it
nnoremap <leader>w <C-w>v<C-w>l

" map Ctrl-h/j/k/l to move around window splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" set default font
set guifont=Monaco:h12
" color molokai
color herald

nmap <silent> <Leader>t :CommandT<CR>
" Open command-t window with list of buffers (not files on disk)
nmap <silent> <Leader>b :CommandTBuffer<CR>

" Fast editing of the .gvimrc file
map <leader>e :e! ~/.gvimrc<cr>

" make search more sane
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" disable arrow keys (force beginners to learn)
" from http://stevelosh.com/blog/2010/09/coming-home-to-vim
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" map prev/next tab to ctrl+alt+h/l
" http://code.google.com/p/macvim/issues/detail?id=156
" macmenukey Window.Select Previous\ Tab <D-M-h>
" macmenukey Window.Select Next\ Tab <D-M-l>

" command to go to gilt directory
command Gilt cd /web/gilt

"ruby
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
"improve autocomplete menu color
" highlight Pmenu ctermbg=238 gui=bold
highlight PMenu gui=bold guibg=#CECECE guifg=#444444

" disable toolbar
"if has("gui_running")
"  set guioptions=-t
"endif 

" wipe out fugitive buffers that are not being used
autocmd BufReadPost fugitive://* set bufhidden=delete

"This allows for change paste motion cp{motion}
nmap <silent> cp :set opfunc=ChangePaste<CR>g@
function! ChangePaste(type, ...)
    silent exe "normal! `[v`]\"_c"
    silent exe "normal! p"
endfunction
