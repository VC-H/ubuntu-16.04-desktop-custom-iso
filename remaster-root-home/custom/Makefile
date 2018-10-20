SHELL = /bin/bash

ifeq ($(shell stat -c %i /),2)
$(error make in chroot filesytem only! ***)
endif

default: # (this message)
	@echo
	@echo "usage: make [target]"
	@echo
	@echo "target:"
	@echo
	@grep "^[^[:space:]].*:" ./Makefile | sed -e "s/^\(.*\):/  \1/g"
	@echo

install: # (main goal)
	rsync -av ./custom/ /
	sudo dconf update

polkitd-restart: # (only for oem installation)
	sudo systemctl restart polkitd.service
