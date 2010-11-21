set nocompatible
set shell=/bin/sh

" == Look
set number
set numberwidth=6
set showcmd
set noshowmode
syntax on
colorscheme zenburn
hi Pmenu          guifg=#7f8f8f guibg=#464646
set listchars=eol:$,tab:»»,trail:·,nbsp:~

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

" == Digraphs ==
" show digraphs table
" TODO: use same buffer every time, open new window if it does not present,
" otherwise switch to it
nmap <Leader>d :redir @a<CR>:silent digraphs<CR>:redir END<CR>:new<CR>:put! a<CR>:let @a=@_<CR>

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

dig \|= 8871 " ⊧ u022a7 is 'models', and ⊨ u022a8 is 'true', but does not fits in single cell
" u022ad 'not true'
abbr ⊧! ⊭ 

dig TO 8868 " ⊤
dig BO 8869 " ⊥

dig [C 8847 " ⊏
dig [_ 8849 " ⊑
abbr ⊑! ⋢
dig ]C 8848 " ⊐
dig _] 8850 " ⊒
abbr ⊒! ⋣

dig [U 8851 " ⊓
dig ]U 8852 " ⊔

dig \|- 8866 " ⊢
dig -\| 8867 " ⊣

dig .= 8784 " ≐

abbr ∈! ∉

"joins
abbr ▷◁  ⋈ 
abbr ▷< ⋉
abbr >◁ ⋊
