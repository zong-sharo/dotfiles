"======================================================================
" cream-colors-zenburn.vim
"
" Cream -- An easy-to-use configuration of the famous Vim text editor
" [ http://cream.sourceforge.net ] Copyright (C) 2001-2007  Steve Hall
"
" License:
" This program is free software; you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation; either version 2 of the License, or
" (at your option) any later version.
" [ http://www.gnu.org/licenses/gpl.html ]
"
" This program is distributed in the hope that it will be useful, but
" WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
" General Public License for more details.
"
" You should have received a copy of the GNU General Public License
" along with this program; if not, write to the Free Software
" Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
" 02111-1307, USA.
"

"+++ Cream: Use Zenburn's built-in Cream adjuster ;)
let g:zenburn_alternate_Visual = 1
"+++

"----------------------------------------------------------------------
" Vim color file
" Maintainer:   Jani Nurminen <jani.nurminen@intellitel.com>
" Last Change:	$Id: cream-colors-zenburn.vim,v 1.6 2007/05/17 01:39:32 digitect Exp $
" URL:		Not yet...
" License:      GPL
"
" Nothing too fancy, just some alien fruit salad to keep you in the zone.
" This syntax file was designed to be used with dark environments and
" low light situations. Of course, if it works during a daybright office, go
" ahead :)
"
" Owes heavily to other Vim color files! With special mentions
" to "BlackDust", "Camo" and "Desert".
"
" To install, copy to ~/.vim/colors directory. Then :colorscheme zenburn.
" See also :help syntax
"
" CONFIGURABLE PARAMETERS:
"
" You can use the default (don't set any parameters), or you can
" set some parameters to tweak the Zenlook colours.
"
" * To get more contrast to the Visual selection, use
"
"      let g:zenburn_alternate_Visual = 1
"
" * To use alternate colouring for Error message, use
"
"      let g:zenburn_alternate_Error = 1
"
" * The new default for Include is a duller orang.e To use the original
"   colouring for Include, use
"
"      let g:zenburn_alternate_Include = 1
"
" * To turn the parameter(s) back to defaults, use unlet.
"
" That's it, enjoy!
"
" TODO
"   - IME colouring (CursorIM)
"   - obscure syntax groups: check and colourize
"   - add more groups if necessary

set background=dark
hi clear
if exists("syntax_on")
	syntax reset
endif
"+++ Cream:
"let g:colors_name="zenburn"
"+++

hi Boolean         guifg=#dca3a3
hi Character       guifg=#dca3a3 gui=bold
hi Comment         guifg=#7f9f7f
hi Conditional     guifg=#f0dfaf gui=bold
hi Constant        guifg=#dca3a3 gui=bold
"+++ Cream:
"hi Cursor          guifg=#000d18 guibg=#8faf9f gui=bold
highlight Cursor       gui=NONE guifg=#ffffff guibg=#ff9020
"+++
hi Debug           guifg=#dca3a3 gui=bold
hi Define          guifg=#ffcfaf gui=bold
hi Delimiter       guifg=#8f8f8f
hi DiffAdd         guifg=#709080 guibg=#313c36 gui=bold
hi DiffChange      guibg=#333333
hi DiffDelete      guifg=#333333 guibg=#464646
hi DiffText        guifg=#ecbcbc guibg=#41363c gui=bold
hi Directory       guifg=#dcdccc gui=bold
hi ErrorMsg        guifg=#60b48a guibg=#3f3f3f gui=bold
hi Exception       guifg=#c3bf9f gui=bold
hi Float           guifg=#c0bed1
hi FoldColumn      guifg=#93b3a3 guibg=#3f4040
"+++ Cream:
"hi Folded          guifg=#93b3a3 guibg=#3f4040
hi Folded          guifg=#93b3a3 guibg=#505050
"+++
hi Function        guifg=#efef8f
hi Identifier      guifg=#efdcbc
hi IncSearch       guibg=#f8f893 guifg=#385f38
hi Keyword         guifg=#f0dfaf gui=bold
hi Label           guifg=#dfcfaf gui=underline
hi LineNr          guifg=#7f8f8f guibg=#464646
hi Macro           guifg=#ffcfaf gui=bold
hi ModeMsg         guifg=#ffcfaf gui=none
hi MoreMsg         guifg=#ffffff gui=bold
hi Normal          guifg=#dcdccc guibg=#3f3f3f
hi Number          guifg=#8cd0d3
hi Operator        guifg=#f0efd0
hi PreCondit       guifg=#dfaf8f gui=bold
hi PreProc         guifg=#ffcfaf gui=bold
hi Question        guifg=#ffffff gui=bold
hi Repeat          guifg=#ffd7a7 gui=bold
hi Search          guifg=#ffffe0 guibg=#385f38
hi SpecialChar     guifg=#dca3a3 gui=bold
hi SpecialComment  guifg=#82a282 gui=bold
hi Special         guifg=#cfbfaf
"+++ Cream:
hi NonText         guifg=#777733 guibg=#333333 gui=none
hi SpecialKey      guifg=#777733 guibg=#333333 gui=none
"+++
hi Statement       guifg=#e3ceab guibg=#3f3f3f gui=none
hi StatusLine      guifg=#1e2320 guibg=#acbc90
hi StatusLineNC    guifg=#2e3330 guibg=#88b090
hi StorageClass    guifg=#c3bf9f gui=bold
hi String          guifg=#cc9393
hi Structure       guifg=#efefaf gui=bold
hi Tag             guifg=#dca3a3 gui=bold
hi Title           guifg=#efefef guibg=#3f3f3f gui=bold
hi Todo            guifg=#7faf8f guibg=#3f3f3f gui=bold
hi Typedef         guifg=#dfe4cf gui=bold
hi Type            guifg=#dfdfbf gui=bold
hi Underlined      guifg=#dcdccc guibg=#3f3f3f gui=underline
hi VertSplit       guifg=#303030 guibg=#688060
hi VisualNOS       guifg=#333333 guibg=#f18c96 gui=bold,underline
hi WarningMsg      guifg=#ffffff guibg=#333333 gui=bold
hi WildMenu        guibg=#2c302d guifg=#cbecd0 gui=underline

if exists("g:zenburn_alternate_Visual")
	" Visual with more contrast, thanks to Steve Hall & Cream posse
	hi Visual          guifg=#000000 guibg=#71d3b4
else
	" use default visual
	hi Visual          guifg=#233323 guibg=#71d3b4
endif

if exists("g:zenburn_alternate_Error")
	" use a bit different Error
	hi Error           guifg=#ef9f9f guibg=#201010 gui=bold
else
	" default
	hi Error           guifg=#e37170 guibg=#332323 gui=none
endif

if exists("g:zenburn_alternate_Include")
	" original setting
	hi Include         guifg=#ffcfaf gui=bold
else
	" new, less contrasted one
	hi Include         guifg=#dfaf8f gui=bold
endif
	" TODO check every syntax group that they're ok

"+++ Cream:

" statusline
highlight User1  gui=bold guibg=#8c9c70 guifg=#606060
highlight User2  gui=bold guibg=#8c9c70 guifg=#000000
highlight User3  gui=bold guibg=#8c9c70 guifg=#ffff66
highlight User4  gui=bold guibg=#8c9c70 guifg=#ff9933

" bookmarks
highlight Cream_ShowMarksHL ctermfg=blue ctermbg=lightblue cterm=bold guifg=Black guibg=#aacc77 gui=bold

" spell check
highlight BadWord ctermfg=black ctermbg=lightblue gui=bold  guibg=#774f3f

" current line
highlight CurrentLine term=reverse ctermbg=0 ctermfg=14 gui=none guibg=#5f5f5f

" email
highlight EQuote1 guifg=#8cd0d3
highlight EQuote2 guifg=#83afaf
highlight EQuote3 guifg=#669999
highlight Sig guifg=#7f8f8f

"+++
