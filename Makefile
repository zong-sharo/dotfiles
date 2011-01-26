CONFIGS = \
		  screenrc \
		  tmux.conf \
		  toprc \
		  conkyrc \
		  xmonad.hs \
		  xinitrc \
		  $(wildcard Xmodmap*) \
		  Xresources \
		  vimperatorrc \
		  pentadactylrc \
		  vimrc \
		  gvimrc \
		  stline.vim \
		  zenburn.vim \
		  config.fish

PATHS = \
		.vimbackup \
		.vimswp
BINS=$(notdir $(wildcard ./bin/*))
FISH_FUNCTIONS=$(notdir $(wildcard ./fish-functions/*))
PENTADACTYL_PLUGINS=$(notdir $(wildcard ./pentadactyl-plugins/*))

PREFIX=$(HOME)
COLLECT_DEST=.

INSTALL.PATH=$(PREFIX)
INSTALL.PATH.xmonad.hs=$(PREFIX)/.xmonad
INSTALL.PATH.stline.vim=$(PREFIX)/.vim/autoload
INSTALL.PATH.zenburn.vim=$(PREFIX)/.vim/colors
INSTALL.PATH.config.fish=$(PREFIX)/.config/fish

BACKUP=numbered
INSTALL.MODE=644
INSTALL.MODE.xinitrc=755


all : $(CONFIGS)

install: paths $(foreach f, $(CONFIGS), install-$(f) ) install-bin install-fish-functions install-pentadactyl-plugins

collect: $(COLLECT_DEST) $(foreach f, $(CONFIGS), collect-$(f) ) collect-bin collect-fish-functions collect-pentadactyl-plugins $(COLLECT_DEST)

install-%: %
	install -D --backup=$(BACKUP) -m $(if $(INSTALL.MODE.$*),$(INSTALL.MODE.$*),$(INSTALL.MODE)) $* $(if $(INSTALL.PATH.$*), $(INSTALL.PATH.$*)/$*, $(INSTALL.PATH)/.$*)

collect-%:
	- cp $(if $(INSTALL.PATH.$*), $(INSTALL.PATH.$*)/$*, $(INSTALL.PATH)/.$*) $(COLLECT_DEST)/$*

install-fish-functions: $(PREFIX)/.config/fish/functions
	install --backup=$(BACKUP) -m $(INSTALL.MODE) ./fish-functions/* $(PREFIX)/.config/fish/functions

collect-fish-functions: $(COLLECT_DEST)/fish-functions
	- cp $(addprefix $(PREFIX)/.config/fish/functions/, $(FISH_FUNCTIONS)) $(COLLECT_DEST)/fish-functions

install-pentadactyl-plugins: $(PREFIX)/.pentadactyl/plugins
	install --backup=$(BACKUP) -m $(INSTALL.MODE) ./pentadactyl-plugins/* $(PREFIX)/.pentadactyl/plugins

collect-pentadactyl-plugins: $(COLLECT_DEST)/pentadactyl-plugins
	- cp $(addprefix $(PREFIX)/.pentadactyl/plugins/, $(PENTADACTYL_PLUGINS)) $(COLLECT_DEST)/pentadactyl-plugins

install-bin: bin/* $(PREFIX)/bin
	install --backup=$(BACKUP) -m 755 bin/* $(PREFIX)/bin/

collect-bin: $(COLLECT_DEST)/bin
	- cp $(addprefix $(PREFIX)/bin/,$(BINS)) $(COLLECT_DEST)/bin

paths: $(foreach p, $(PATHS), $(PREFIX)/$p)

$(PREFIX)/%/:
	mkdir -p $@
