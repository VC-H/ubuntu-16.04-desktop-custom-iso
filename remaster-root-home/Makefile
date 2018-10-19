SHELL = /bin/bash

DQUERY = dpkg-query -Wf '$${Package}\n'
DSQUERY = dpkg-query -Wf '$${Installed-Size}\t$${Package}\n'
PURGE = apt-get autoremove --purge $(o)
XPURGE = xargs $(PURGE)
NL = \
"cjk|chinese|japanese|korean|tibet\
|arabic|ethiopia|sinhala|punjabi\
|myanmar|khmer|lao|thai"
o = --yes

default:
	@echo
	@echo "** WARNING! make on the target filesytem only! **"
	@echo
	@echo "usages:"
	@echo
	@echo "  make customize o=--yes # (main goal)"
	@echo "  make [target] [o=--yes] # (default is o=--dry-run)"
	@echo
	@echo "targets:"
	@echo
	@grep "^[^[:space:]].*:" ./Makefile |\
	sed -e "s/^/  /g" -e "s/:.*$$//g" | column
	@echo

query:
	@$(DQUERY)

size-query:
	@${DSQUERY} | sort -n

purge:
	@$(PURGE)

findmnt:
	@findmnt -ln -o TARGET,SOURCE |\
	sed -e "s/\[.*remaster/[..\/remaster/g"

no-game:
	@dpkg -l | grep game | tr -s " " | cut -f2 -d\  | ${XPURGE}

no-webapp:
	@${PURGE} webbrowser-app

no-online-account:
	@${DQUERY} | grep account.plugin | $(XPURGE)

scope-home-only:
	@${DQUERY} | grep ^unity.scope\- | grep -v home | $(XPURGE)

no-lens-media:
	@${DQUERY} | grep ^unity.lens | egrep -v "app|files" | $(XPURGE)

no-thunderbird:
	@$(DQUERY) | grep thunderbird | $(XPURGE)

no-scanner:
	@${PURGE} simple-scan

no-shotwell:
	@$(DQUERY) | grep shotwell | $(XPURGE)

no-totem:
	@$(DQUERY) | grep totem | $(XPURGE)

no-rhythmbox:
	@$(DQUERY) | grep rhythmbox | $(XPURGE)

no-office:
	@$(DQUERY) | grep ^libreoffice | $(XPURGE)

no-mythes:
	@${DQUERY} | grep ^mythes | $(XPURGE)

no-remmina:
	@$(DQUERY) | grep ^remmina | $(XPURGE)

no-bittorrent:
	@$(DQUERY) | grep transmission | $(XPURGE)

no-snap:
	@$(DQUERY) | grep snap | $(XPURGE)

en-only:
	@$(DQUERY) | grep ^language.pack | grep -v \\-en | $(XPURGE)

ls-fonts:
	@dpkg-query -Wf '$${Section}\t$${Package;-32}\t$${Description}\n' |\
	grep ^fonts | cut -f2,3

ls-basic-fonts:
	@make --quiet ls-fonts | egrep -iv $(NL)

ls-other-fonts:
	@make --quiet ls-fonts | egrep -i $(NL) | cat

no-other-fonts:
	@make --quiet ls-other-fonts | cut -f1 | $(XPURGE)

no-big-manual:
	@$(PURGE) gnome-user-guide ubuntu-docs example-content

no-ime:
	@( echo tegaki-zinnia-japanese ;\
	echo libfcitx-qt5-1 ;\
	$(DQUERY) | grep mozc ) |\
	$(XPURGE)

no-fcitx:
	@${DQUERY} | grep ^fcitx | $(XPURGE)

firefox-en-only:
	@${DQUERY} | grep firefox\-locale | $(XPURGE)

all-no-only-all:
	@egrep "^no|only:$$" ./Makefile | tr -d ":"

smaller:
	make --quiet all-no-only-all | xargs make --quiet o=$(o)

install-custom:
	rm -rf /opt/custom
	cp -r ./custom /opt/

sudoers:
	cp ./sudoers.d/custom /etc/sudoers.d/

customize: smaller sudoers install-custom
	( cd /opt/custom ; make install )
