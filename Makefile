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
		.vimbackup \
		.vimswp
BINS=$(notdir $(wildcard ./bin/*))

PREFIX=$(HOME)
COLLECT_DEST=.

INSTALL.PATH=$(PREFIX)
INSTALL.PATH.xmonad.hs=$(PREFIX)/.xmonad
INSTALL.PATH.stline.vim=$(PREFIX)/.vim/autoload
INSTALL.PATH.zenburn.vim=$(PREFIX)/.vim/colors

BACKUP=numbered
INSTALL.MODE=644
INSTALL.MODE.xinitrc=755
INSTALL.MODE.snap=755
INSTALL.MODE.reminder=755


all : $(CONFIGS)

install: paths $(foreach f, $(CONFIGS), install-$(f) ) install-bin

collect: $(COLLECT_DEST) $(foreach f, $(CONFIGS), collect-$(f) ) collect-bin $(COLLECT_DEST)

install-%: %
	install -D --backup=$(BACKUP) -m $(if $(INSTALL.MODE.$*),$(INSTALL.MODE.$*),$(INSTALL.MODE)) $* $(if $(INSTALL.PATH.$*), $(INSTALL.PATH.$*)/$*, $(INSTALL.PATH)/.$*)

collect-%:
	- cp $(if $(INSTALL.PATH.$*), $(INSTALL.PATH.$*)/$*, $(INSTALL.PATH)/.$*) $(COLLECT_DEST)/$*

install-bin: bin/* $(PREFIX)/bin
	install --backup=$(BACKUP) -m 755 bin/* $(PREFIX)/bin/

collect-bin: $(COLLECT_DEST)/bin
	- cp $(addprefix $(PREFIX)/bin/,$(BINS)) $(COLLECT_DEST)/bin

paths: $(foreach p, $(PATHS), $(PREFIX)/$p)

$(PREFIX)/%/:
	mkdir -p $@
