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
" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" map prev/next tab to ctrl+alt+h/l
" http://code.google.com/p/macvim/issues/detail?id=156
" macmenukey Window.Select Previous\ Tab <D-M-h>
" macmenukey Window.Select Next\ Tab <D-M-l>

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

" set file type to Ruby
command! FR set filetype=ruby

" open RubyRunner results buffer below code buffer
let g:RubyRunner_open_below = 1

" open new splits below current
" http://vim.wikia.com/wiki/Opening_new_buffer_below_the_current
set splitbelow

" function to wipe out all buffers that are not currently shown anywhere
" http://stackoverflow.com/questions/1534835/how-do-i-close-all-buffers-that-arent-shown-in-a-window-in-vim
function! Wipeout()
  " list of *all* buffer numbers
  let l:buffers = range(1, bufnr('$'))

  " what tab page are we in?
  let l:currentTab = tabpagenr()
  try
    " go through all tab pages
    let l:tab = 0
    while l:tab < tabpagenr('$')
      let l:tab += 1

      " go through all windows
      let l:win = 0
      while l:win < winnr('$')
        let l:win += 1
        " whatever buffer is in this window in this tab, remove it from
        " l:buffers list
        let l:thisbuf = winbufnr(l:win)
        call remove(l:buffers, index(l:buffers, l:thisbuf))
      endwhile
    endwhile

    " if there are any buffers left, delete them
    if len(l:buffers)
      execute 'bwipeout' join(l:buffers)
    endif
  finally
    " go back to our original tab page
    execute 'tabnext' l:currentTab
  endtry
endfunction

command! Cleanup call Wipeout()

" load .vimrc-local if it exists
if !empty(glob("~/.vimrc-local"))
  source ~/.vimrc-local
endif

" prettify json file
map <leader>jt  <Esc>:%!json_xs -f json -t json-pretty<CR>

" go to previous file in buffer
" http://vimbits.com/bits/181
nmap <leader><leader> :b#<cr>

" The Smash Escape - type jk or kj to exit edit mode
" http://vimbits.com/bits/180
inoremap jk <Esc>
inoremap kj <Esc>

" Makes C-j & C-k scroll forward/back in history in command-line mode, and makes C-a & C-e act as Home/End in command-line mode.
" http://vimbits.com/bits/30
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" use space to toggle search highlights
" http://vimbits.com/bits/52
noremap <space> :set hlsearch! hlsearch?<CR>

" Map Q to repeat the last recorded macro
" http://vimbits.com/bits/263
map Q @@

" Highlight trailing whitespace
" and evil tabs
" plus my toggle code
" http://vimbits.com/bits/259
function! ToggleEvilCharacters()
  if exists("b:evil_chars_hi") && b:evil_chars_hi
    highlight clear WhitespaceEOL
    highlight clear TabsAreEvil
    let b:evil_chars_hi = 0
    echo "evil chars highlight off"
  else
    highlight WhitespaceEOL ctermbg=Red guibg=Red
    match WhitespaceEOL /\s\+$/

    highlight TabsAreEvil ctermbg=Yellow guibg=Yellow
    2match TabsAreEvil /\t\+/

    let b:evil_chars_hi = 1
    echo "evil chars highlight on"
  endif
endfunction

nnoremap <silent> <CR> :call ToggleEvilCharacters()<CR>

" Expand path of current file in command mode
" (there is already a variable to print file name as well: @%)
" http://vimbits.com/bits/199
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Use <C-h> and <C-l> to move left/right in insert mode
" mah vimbits
" http://vimbits.com/bits/277
" inoremap <C-h> <left>
" inoremap <C-l> <right>

" open/close quotes and doublequotes like textmate does
" http://vimbits.com/bits/165
" noremap! "" ""<left>
" noremap! '' ''<left>

" press <leader>G to go to the end of teh current file and insert new line
" below
noremap <leader>G Go

" Highlight word at cursor and then Ack it. (cmd-8)
" :help key-notation
" to figure out how to specify keys that can be used for mapping
" http://vimbits.com/bits/19
nnoremap <D-8> *<C-O>:AckFromSearch!<CR>

" replace tabs with 4 or 2 spaces
command! Tabs4spaces perldo s/\t/    /g
command! Tabs2spaces perldo s/\t/  /g
