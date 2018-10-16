SHELL = /bin/bash

default: # (default) this message
	@echo
	@echo "** WARNING! make on the target filesytem only! **"
	@echo
	@echo "usage: make [target]"
	@echo
	@echo "target:"
	@echo
	@grep "^[^[:space:]].*:" ./Makefile | sed -e "s/^\(.*\):/  \1/g"
	@echo

install:
	( cd custom ; sudo tar cf - . ) | ( cd / ; sudo tar xvf - )
	sudo dconf update

polkitd-restart:
	sudo systemctl restart polkitd.service
