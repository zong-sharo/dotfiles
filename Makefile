CONFIGS = \
		  zshrc \
		  screenrc \
		  toprc \
		  conkyrc \
		  xmonad.hs \
		  xinitrc \
		  Xmodmap \
		  Xresources \
		  vimperatorrc \
		  vimrc \
		  gvimrc \
		  stline.vim \
		  zenburn.vim

PATHS = \
		.vim/colors \
		.vim/autoload \
		.vimbackup \
		.vimswp \
		.xmonad

BACKUP=numbered
MODE=644
INSTALL=install --backup=$(BACKUP) --mode=$(MODE)


all : $(CONFIGS)

install-%: %
	$(INSTALL) $* $(HOME)/.$* 

collect-%:
	- cp $(HOME)/.$* $*

install-xmonad.hs: xmonad.hs
	$(INSTALL) $< $(HOME)/.xmonad/$<

collect-xmonad.hs:
	cp $(HOME)/.xmonad/xmonad.hs xmonad.hs

install-stline.vim: stline.vim
	$(INSTALL) $< $(HOME)/.vim/autoload/$<

collect-stline.vim:
	cp $(HOME)/.vim/autoload/stline.vim stline.vim

install-zenburn.vim: zenburn.vim
	$(INSTALL) $< $(HOME)/.vim/colors/$<

collect-zenburn.vim:
	cp $(HOME)/.vim/colors/zenburn.vim zenburn.vim

install-xinitrc: xinitrc
	install --backup=$(BACKUP) --mode=755 $< $(HOME)/.$<

install: paths $(foreach f, $(CONFIGS), install-$(f) )

collect: $(foreach f, $(CONFIGS), collect-$(f) )

#makepath-%:
#	if [[ ! -d $(HOME)/$* ]]; then mkdir -p $(HOME)/$*; fi

paths: $(foreach p, $(PATHS), $(HOME)/$p)

$(HOME)/%/:
	mkdir -p $@
