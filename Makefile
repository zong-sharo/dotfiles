CONFIGS = \
		  zshrc \
		  screenrc \
		  toprc \
		  conkyrc

BACKUP=numbered

default: all

all : $(CONFIGS)

install-file-%: %
	install --backup=$(BACKUP) --mode=644 $* $(HOME)/.$* 

install: $(foreach f, $(CONFIGS), install-file-$(f) )
