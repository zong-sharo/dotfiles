CONFIGS = \
		  zshrc \
		  screenrc \
		  toprc \
		  conkyrc \
		  xmonad.hs

BACKUP=numbered
INSTALL=install --backup=$(BACKUP) --mode=644

default: all

all : $(CONFIGS)

install-file-%: %
	$(INSTALL) $* $(HOME)/.$* 

install-file-xmonad.hs: xmonad.hs
	$(INSTALL) $< $(HOME)/.xmonad/$<

install: $(foreach f, $(CONFIGS), install-file-$(f) )
