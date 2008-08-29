CONFIGS = \
		  zshrc \
		  screenrc \
		  toprc \
		  conkyrc \
		  xmonad.hs \
		  xinitrc \
		  Xresources

BACKUP=numbered
MODE=644
INSTALL=install --backup=$(BACKUP) --mode=$(MODE)

default: all

all : $(CONFIGS)

install-file-%: %
	$(INSTALL) $* $(HOME)/.$* 

install-file-xmonad.hs: xmonad.hs
	$(INSTALL) $< $(HOME)/.xmonad/$<

install-file-xinitrc: xinitrc
	install --backup=$(BACKUP) --mode=755 $< $(HOME)/.$<

install: $(foreach f, $(CONFIGS), install-file-$(f) )
