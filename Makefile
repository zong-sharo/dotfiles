CONFIGS = \
		  zshrc \
		  screenrc \
		  toprc \
		  conkyrc \
		  xmonad.hs \
		  xinitrc \
		  Xmodmap \
		  Xresources \
		  vimperatorrc

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

install-xinitrc: xinitrc
	install --backup=$(BACKUP) --mode=755 $< $(HOME)/.$<

install: $(foreach f, $(CONFIGS), install-$(f) )

collect: $(foreach f, $(CONFIGS), collect-$(f) )
