set shell=/bin/sh
" * vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" bundles
Bundle 'gmarik/vundle'
Bundle 'vimwiki'
Bundle 'gnupg.vim'
Bundle 'tpope/vim-surround'

" colorthemes
Bundle 'jnurmine/Zenburn'

filetype plugin indent on
" vundle init done

" * Colorscheme
syntax on
set background=dark
colorscheme zenburn

" * Look
set number
set numberwidth=6
set showcmd
set noshowmode
set listchars=eol:$,tab:»»,trail:·,nbsp:~
set winminheight=0

" * Statusline
set laststatus=2
set statusline=
"set statusline+=%1*                          " User1
set statusline+=\ \|%n\|                      " buf no
"set statusline+=%2*                          " User2
set statusline+=\ %{stline#Filename()}        " fname
"set statusline+=%3*                          " User3
set statusline+=\ %{stline#Bufferstate()}     " ro/rw/unsaved/help
"set statusline+=%1*                          " User1
set statusline+=\|%{stline#Fileinfo(':')}\|   " finfo
set statusline+=\ %=                          " rpadding
set statusline+=%{stline#Tabinfo()}           " tabstop/softabstop
set statusline+=\ %5l/%L,%-5v                 " line/total,col
"set statusline+=%2*                          " User2
set statusline+=%3P                           " perc through file

" * Behavior
set nofoldenable
set wildmenu
set linebreak
set textwidth=80
set matchpairs=(:),{:},[:],<:> " ??/:/??
set backspace=indent,eol,start " backspace for insert mode
set history=1000
set encoding=utf8
set fileencodings=utf8
set mousemodel=extend " mouse behavior like gpm
set completeopt=menu " no previev
" default ft is text
autocmd BufEnter * if &filetype == "" | setlocal ft=text | endif
autocmd BufEnter * setlocal bufhidden=delete "auto-clean buffers

" ** Binds
map <C-N> <C-X><C-O>
"omni completion, broken bind XXX
map <S-Insert> <MiddleMouse>

" ** Search
set hlsearch 
set ignorecase smartcase
set incsearch 

" ** Indent
set nocindent
set autoindent
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4

" ** Backup
set backup
set backupdir=~/.vim/backup
set backupext=.bak
set dir=~/.vim/swp

" ** Persistent Undo
set undofile
set undodir=~/.vim/undo

" * vimwiki
autocmd FileType vimwiki setlocal tabstop=2 softtabstop=2 shiftwidth=2
"autocmd Filetype vimwiki setlocal listchars=trail:· list
let g:vimwiki_ext2syntax = {'.wiki': 'markdown'} "markdown everywhere

if filereadable($HOME."/notes/.vimrc")
    source ~/notes/.vimrc
endif

autocmd FileType c setlocal matchpairs-=<:>

" * Digraphs

" utility command to define digraphs by hex
function l:d(args)
    let l:args_ = split(a:args)
    execute 'dig ' . l:args_[0] . ' ' . eval(l:args_[1])
endfunction

com -nargs=+ Dig call l:d('<args>')

" show digraphs table
" TODO: use same buffer every time, open new window if it does not present,
" otherwise switch to it
nmap <Leader>d :redir @a<CR>:silent digraphs<CR>:redir END<CR>:new<CR>:put! a<CR>:let @a=@_<CR>

" ** superscripts and subscripts
dig S0 8304 " ⁰
dig S1 185  " ¹
dig S2 178  " ²
dig S3 179  " ³
dig S4 8308 " ⁴
dig S5 8309 " ⁵
dig S6 8310 " ⁶
dig S7 8311 " ⁷
dig S8 8312 " ⁸
dig S9 8313 " ⁹
dig S+ 8314 " ⁺
dig S- 8315 " ⁻
dig S= 8316 " ⁼
dig S( 8317 " ⁽
dig S) 8318 " ⁾
dig Si 8305 " ⁱ
dig Sn 8319 " ⁿ

dig s0 8320 " ₀
dig s1 8321 " ₁
dig s2 8322 " ₂
dig s3 8323 " ₃
dig s4 8324 " ₄
dig s5 8325 " ₅
dig s6 8326 " ₆
dig s7 8327 " ₇
dig s8 8328 " ₈
dig s9 8329 " ₉
dig s+ 8330 " ₊
dig s- 8331 " ₋
dig s= 8332 " ₌
dig s( 8333 " ₍
dig s) 8334 " ₎
dig si 7522 " ᵢ

" ** math symbols
Dig \|= 0x22a7 " ⊧ models
"⊨ u022a8 is 'true', but u22a8 does not fits in single cell
" u022ad 'not true'
abbr ⊧! ⊭ 

Dig TO 0x22A4 " ⊤ top
Dig BO 0x22A5 " ⊥ bottom

Dig [C 0x228F " ⊏ square image of
Dig [_ 0x2291 " ⊑ square image or equal to
abbr ⊑! ⋢

Dig ]C 0x2290 " ⊐ square original of
Dig _] 0x2292 " ⊒ square original or equal to
abbr ⊒! ⋣

Dig [U 0x2293 " ⊓ square cap
Dig ]U 0x2294 " ⊔ square cup

Dig \|- 0x22a2 " ⊢ right tack
Dig -\| 0x22a3 " ⊣ left tack

Dig .= 0x2250 " ≐ geomerically equal to

abbr ∈! ∉

"joins
abbr ▷◁  ⋈ 
abbr ▷< ⋉
abbr >◁ ⋊
abbr →> ↠
abbr <← ↞
