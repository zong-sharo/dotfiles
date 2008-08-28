CONFIGS = \
		  zshrc \
		  screenrc

BACKUP=numbered

default: all

all : $(CONFIGS)

install-file-%: %
	install --backup=$(BACKUP) $* $(HOME)/.$* 

install: $(foreach f, $(CONFIGS), install-file-$(f) )
