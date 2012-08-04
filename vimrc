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

filetype indent on
" vundle init done

" * Look
set number
set numberwidth=6
set showcmd
set noshowmode
syntax on
colorscheme zenburn
hi Pmenu          guifg=#7f8f8f guibg=#464646
set listchars=eol:$,tab:»»,trail:·,nbsp:~

" * Statusline
set laststatus=2
set statusline=%1*\ \|%n\|\
\ %2*%{stline#Filename()}\
\ %3*%{stline#Bufferstate()}%1*\|%{stline#Fileinfo(':')}\|\
\ %=%{stline#Tabinfo()}%5l/%L,%-5v%2*%3P

" * Behavior
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
set completeopt=menu " no previev

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
set backupdir=~/.vimbackup
set backupext=.bak
set dir=~/.vimswp

" * viki.vim
autocmd BufRead,BufNewFile *.viki set filetype=viki
autocmd BufEnter *.viki setlocal tabstop=2 softtabstop=2 shiftwidth=2
let g:vikiUpperCharacters="A-ZА-Я"
let g:vikiLowerCharacters="a-zа-я"
hi! link vikiInexistentLink Error
let g:viki_highlight_inexistent_dark=""
"let g:vikiFancyHeadings=1

if filereadable($HOME."/notes/.vimrc")
    source ~/notes/.vimrc
endif

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
