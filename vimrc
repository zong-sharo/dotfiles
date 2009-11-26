set nocompatible

" == Look
set number
set numberwidth=6
set showcmd
set noshowmode
syntax on
colorscheme zenburn
hi Pmenu          guifg=#7f8f8f guibg=#464646

" === Statusline ===
set laststatus=2
set statusline=%1*\ \|%n\|\
\ %2*%{stline#Filename()}\
\ %3*%{stline#Bufferstate()}%1*\|%{stline#Fileinfo(':')}\|\
\ %=%{stline#Tabinfo()}%5l/%L,%-5v%2*%3P

" == Behavior ==
set nofoldenable
set wildmenu
set linebreak
"set textwidth=70
set matchpairs=(:),{:},[:],<:> " ??/:/??
set backspace=indent,eol,start " backspace for insert mode
set history=1000
set encoding=utf8
set fileencodings=utf8
set mousemodel=extend " mouse behavior like gpm
set hidden " don't wipe buffer on unload
set completeopt=menu " no previev

" == Binds  ===
map <C-N> <C-X><C-O>
"omni completion, broken bind XXX
map <S-Insert> <MiddleMouse>

" === Search ===
set hlsearch 
set ignorecase smartcase
set incsearch 

" === Indent ===
filetype plugin indent on
set nocindent
set autoindent
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4

" == Backup ==
set backup
set backupdir=~/.vimbackup
set backupext=.bak
set dir=~/.vimswp

" == TOhtml ==
let html_number_lines=0
let html_use_css=1
let html_use_encoding='UTF-8'

" == grep.vim ==
let Grep_Default_Options = '-i'

" == Vimwiki ==
let g:vimwiki_home="~/vimwiki/"
autocmd BufEnter *.wiki set shiftwidth=1
