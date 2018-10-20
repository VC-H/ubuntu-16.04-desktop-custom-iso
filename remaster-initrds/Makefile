SHELL = /bin/bash

CASPER = ../remaster-iso/casper
CI = cpio -id --no-absolute-filenames
CO = cpio -H newc -o


default: # (this message)
	@echo
	@echo "usages:"
	@echo "  make initrd.packed"
	@echo "  make [target]"
	@echo
	@echo "targets: (in workflow order)"
	@echo
	@grep "^[^[:space:]\.].*:" ./Makefile |\
	sed -e "s/^/  /g" -e "s/:$$//g"
	@echo

rd%: initrd-% # (rd% directory of initrd-%)
	test -d $@ || mkdir $@ && ( cd $@ ; $(CI) < ../$< )

initrd-0:
	cp $(CASPER)/initrd $@

initrd-1: rd0
	dd if=initrd-0 skip=56 of=$@

initrd-2: rd1
	dd if=initrd-1 skip=2952 | lzcat > $@

initrd2%: rd2%
	( cd $< ; find | $(CO) | lzma -z >  ../$@ )

initrd%: rd%
	( cd $< ; find | $(CO) > ../$@ )

rd2.1: rd2
	rsync -a rd2/ rd2.1
	rsync -av custom/ rd2.1

initrd-custom: initrd0 initrd1 initrd2.1
	cat $+ > $@

clean:
	rm -f initrd-custom
	rm -f initrd[012]*
	rm -rf rd[012]*
	rm -f initrd-[012]

.PHONY: rd2.1
