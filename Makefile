SHELL = /bin/bash

SRC = .
UBUNTU = ubuntu-16.04.5-desktop
CUSTOM = $(UBUNTU)-custom
ISO_UBUNTU = $(SRC)/$(UBUNTU)-amd64.iso
ISO_CUSTOM = $(CUSTOM)-amd64.iso


ifeq ($(shell test -e $(ISO_UBUNTU) || echo no), no)
$(info )
$(info $(ISO_UBUNTU) not found!)
$(info )
$(error )
endif


default: # this message
	@echo
	@echo "usage: make [target]"
	@echo
	@echo "targets: (in workflow order)"
	@echo
	@grep "^[^[:space:]].*:" ./Makefile |\
	sed -e "s/^/  /g" -e "s/:$$//g"
	@echo

remaster-iso: $(ISO_UBUNTU)
	sudo uck-remaster-unpack-iso $(ISO_UBUNTU) .

remaster-root: remaster-iso
	sudo uck-remaster-unpack-rootfs .

chroot: remaster-root
	sudo uck-remaster-chroot-rootfs .

findmnt:
	@findmnt --list --noheadings -o TARGET | grep remaster | cat

umount:
	@make --quiet findmnt | while read d ; do sudo umount $${d} ; done

chroot-umount: chroot # (umount when chroot exits)
	make --quiet umount

customize: # (make customize in /root of chroot)
	sudo uck-remaster-chroot-rootfs . \
	/bin/bash -c "(cd /root ; make customize)"

pack-rootfs: umount
	sudo uck-remaster-pack-rootfs .

custom-preseed:
	sudo rsync -av ./remaster-root-home/iso/ ./remaster-iso

pack-iso:
	sudo uck-remaster-pack-iso $(ISO_CUSTOM) . \
	--generate-md5 --description=$(CUSTOM)

pack: pack-rootfs custom-preseed pack-iso
iso: remaster-root customize pack

clean:
	sudo rm -rf ./remaster-root
	sudo rm -rf ./remaster-apt-cache
	sudo rm -rf ./remaster-iso

clean-all:
	make clean
	sudo rm -rf ./remaster-new-files

purge:
	find . -name "*~" -exec rm {} +
