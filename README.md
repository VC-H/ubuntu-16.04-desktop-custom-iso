# ubuntu-16.04-desktop-custom-iso

This repository is for building a custom live/installation medium
based the official `ubuntu-16.04.5-desktop-amd64.iso`.  The repository
consists of a set of files to add to installation medium for the
target host.  The building process of the custom medium is performed
by a set of *Makefile*s.

## Building the iso

* Platform: ubuntu-16.04.5-desktop-amd64
* Download: `ubuntu-16.04.5-desktop-amd64.iso`
* Prerequisite: uck (Ubuntu Customization Kit)
* To build

```shell
git clone https://github.com/VC-H/ubuntu-16.04-desktop-custom-iso.git custom
cd custom
make iso
```

### A screencast

![screenshot](https://github.com/VC-H/ubuntu-16.04-desktop-custom-iso/wiki/screencast.gif)

## Custom features

* Preseed ([$iso:/preseed/custom.seed](
  remaster-root-home/iso/preseed/custom.seed)) and
  preset ([$initrd:/etc/casper.conf](
  remaster-initrds/custom/etc/casper.conf))
	- hostname: `custom`
    - username: `customuser`
    - password: `custom`

* Custom wallpaper ([/opt/custom/share/backgrounds/custom.jpg](
  remaster-root-home/custom/share/backgrounds/custom.jpg))

* Radiance theme ([/etc/dconf/db/local.d/](
  remaster-root-home/custom/custom/etc/dconf/db/local.d/))

* Logout to restart automatic login ([/etc/lightdm/](
  remaster-root-home/custom/custom/etc/lightdm/))

* Settings disabled ([/etc/polkit-1/localauthority/](
  remaster-root-home/custom/custom/etc/polkit-1/localauthority/))
  - Lock screen
  - User switching
  - User administration
  - Suspend system

* Lockdown on custom features (
  [/etc/dconf/db/local.d/locks/00_custom_keys](
  remaster-root-home/custom/custom/etc/dconf/db/local.d/locks/00_custom_keys))

* Removed preinstalled packages (
  [$remaster-root-home/Makefile](
  remaster-root-home/Makefile))
    - libreoffice, thunderbird, ...

* Additional packages from source *universe*
  ([$remaster-root-home/Makefile.add](
  remaster-root-home/Makefile.add))
	- `python-qt4`, `python-qt4-dbus`, ...

* [$remaster-root-home/custom/](remaster-root-home/custom/)
  as a 3rd party installaton package to `/opt/`
    - [/opt/custom/bin/customapp.py](
	  remaster-root-home/custom/bin/customapp.py)
	  to execute `lastb` as a gtk app;

* Installed ![](https://avatars1.githubusercontent.com/u/23016403?s=20&v=1)
  [/usr/share/applications/customapp.desktop](
  remaster-root-home/custom/custom/usr/share/applications/customapp.desktop) to
    -  execute [sudo /opt/custom/bin/customapp.py](
       remaster-root-home/custom/bin/customapp.py)

* Granted `customuser` `sudo /opt/custom/bin/customapp.py` without password;

## Makefiles

The *Makefiles* contain many options for building, details in the
[wiki](https://github.com/VC-H/ubuntu-16.04-desktop-custom-iso/wiki).
