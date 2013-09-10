```metadata
title: Switching to Ubuntu Linux
date: 2007-09-26
abstract: A log of my Windows to Linux migration
```

If you haven't heard of Ubuntu yet, it's a flavour of Linux that's based on
Debian. To save me the time of writing out why you should be using Ubuntu
instead of Windows (or anything else for that matter), all you need to do is
have a browse round here: [Why Linux is Better][].

The first thing you should try is running Ubuntu from a Live CD. Just change
your BIOS settings to enable booting from CD and you'll be there. If your happy,
next you should be looking at backing up. Instead, I was looking to *upgrade* my
vanilla XP install by using a customised XP disk with nLite. Below is a log of
how I went about it.

## Deciding To Use Ubuntu

I first created a new XP Slipstream disk that contained 64KB cluster size fix:
XPSP2 does not normally allow installation on anything other than 4KB cluster
size. Unfortunately, the "fix" didn't work and I was presented with *Page_Fault
Stop Error*'s.

Even after rebooting, the error reappeared, stopping me from continuing with the
XP installation. Possible casue for this could have been I didn't delete and
recreate the Temp Partition after installing Windows and assigning the pagefile
to it.

Currently, we haven't found a way of installing Windows on anything but 4KB, but
the Temp Partition (w/ 64KB) **will** work if recreated as above. Also note that
Windows will only install to a **primary** partition and you can only have 4
primary partitions (remembering that an extended partition uses up a primary
partition slot).

**If creating a NTFS TEMP partition for XP (by setting up partitions before
installing Windows), make sure you delete it and re-create it after Windows has
installed.**

So I had to find a way of reformatting the drive without using a Windows tool. I
was going to use Ubuntu's FDISK (during Live CD use), but instead thought it
would be a better idea to make the jump and actually convert to Ubuntu instead.
I briefly looked up on Linux software equivalents and came to the conclusion
that I would only need to use XP again for Cubase (& no Linux drivers for EMU
1616m) and possibly for games.

## Ubuntu Changeover Log

*Note: it gets rough from here on...*

`Sun 16 Sep 2007 21:32:43`

### Backing Up From Windows

* Backed up all obvious folders, like My Documents etc.
* Backed up various application settings and profiles
* Safely moved all non-redudant backups to external hard-drive

### Formatting Drive

After backing up, I decided that I wanted to have my 2 years in use
hard-drive completely formatted:

* First booted Ubuntu using the Live CD
* Securely formatted the hard-drive using:

```bash
sudo shred -n1 -v /dev/hda
```

* Reboot and run the Ubuntu Installer

#### Partition scheme

Extended:

* Linux Swap 1.5GB
* / (Root) Linux 20GB
* /home 30GB
* Finish the install
* Boot to XP (Slipstream CD)

Create 2 further partitions (as primary):

* Primary: --- Windows 2.9GB
* Primary: --- Programs 18GB

### Recovering Linux Boot Manager

After Windows has been installed, it installs it's own bootloader, which
hides our Linux install from the system. To allow us to boot back into
Linux, we need to [recover grub][]. Used this for the Windows entry:

```
title           Microsoft Windows XP Home
root            (hd0,1)
makeactive
chainloader +1
```

### Ubuntu Installed

* Now Ubuntu is installed, I am looking for user guides to help ease the
  transition.
* Picked up a few (rather out-of-date) Linux books from the Library.
* Got a good eBook
* Got [.docx to work in OO][]

### Installed Opera 9.5

This was hard as I used my XP backup that had `D:\\Opera\\` for the paths
used. I had to manually change the paths to their new linux equivelents;
in the GUI and by editing the .adr files. Opera kept re-creating
folders/files outside of the new profile folder, but I managed to
replace all the old paths eventually. Remember, all paths used by Opera
can be checked by enterring opera:about When updating programs (such as
new Opera builds) in Ubuntu, (after running the .deb file) it will
automatically detect that there was a previous version and will
replace/update it perfectly.

* To add items to the Start Bar; goto: `/home/tom/.opera/toolbar` and enter
  manually
* To remove "Search With..." after update: `/usr/share/opera/locale/english.lng`
* Installed Automatix

### Laptop Drivers For Linux

* Graphics: Intel i915GM --- Stock
* Driver Version: Intel VGA driver 6.14.10.4250
* Audio: Conexant --- Stock Driver
* Version: Conexant Audio driver 6.13.10.8335

I have the Intel i915GM onboard graphics chipset and although the drivers are
already included in the distro, there is extra work to be done for it to run at
native resolution. Luckily I found some documentation [explaining the
process][]. I then ran the autoi915 script and all seems fine!

### Fonts

I thought that even after changing my default resolution back to the
monitor's native, the fonts still looked quite bad. Firstly, I had to
find [change the DPI to 96][] using:

```
DisplaySize    338 211 # 1280x800 96dpi
```

After running the `xdpyinfo | grep resolution` command, my dpi would never be
96x96. After searching around, I found there is a [bug in the xorg.config][]
file. Apply the fix worked. Instead of following the rest of that guide, I found
[a script][] that automates installing MS fonts for a great look. I later
installed Lucida Console manually. I have now changed the system fonts (in
System/Preferance/Font) to Tahoma 8.25 (the default XP) for all system fonts
except Fixed Width Font to Lucida Console 10.

### Ubuntu Control Panel

* [Disabled Desktop Effects][]
* Set UK as default Keyboard
* Added Control Panel to preferences
* Changed Opera to default browser
* Changed Power settings (Change the "Regard system as idle" in screensaver to 1
  minute for shorter times)
* Changed Mouse Pointer to White Glass (2nd size) and increased the acceleration
  slightly
* Disabled System Beep

### Programs Uninstalled

* Totem Player
* Tomboy Notes
* Games
* Gaim
* Evolution Mail
* Bittorrent

### Programs Installed

* Opera
* VLC
* Automatix
* DocX for OO
* Pidgin (the new Gaim)
* Flash Plugin
* VLC and Plugin
* [HOSTS Adblock file][]
* 7-Zip
* Unrar (non free)
* Brightside --- Top Left: Mute, Bottom Left: Desktop, Top Right: Off,
  Bottom Right: Screensaver. Switch to adjecent workspace and wrap on.
* The [new OpenOffice][]
* Converted Office 2007 Templates --- find out how to put document properties
  title
* Moblock (PeerGuardian)
* Workrave
* TuxGuitar (Guitar Pro)

### Todo

* Clear Type Opera
* Get Wireless Going
* Find out why Ubuntu crashes when the EMU–1616 is in
* Find out how to uninstall Firefox
* Sort out services
* Sort out Pidgin (it's out of date)
* Sort out backups
* Update favourite software with Ubuntu's alternatives

Fin!

  [explaining the process]: https://help.ubuntu.com/community/i915Driver
  [change the DPI to 96]: http://ubuntuforums.org/showpost.php?p=99808&postcount=1
  [bug in the xorg.config]: http://ubuntuforums.org/showpost.php?p=2663087&postcount=19
  [a script]: http://www.stchman.com/ms_fonts.html
  [Disabled Desktop Effects]: https://help.ubuntu.com/community/DesktopEffects?highlight=(effects)%7C(desktop)
  [HOSTS Adblock file]: http://www.hosts-file.net/?s=Download
  [new OpenOffice]: https://bugs.launchpad.net/ubuntu/+source/openoffice.org/+bug/93002/comments/12
  [Why Linux is Better]: http://www.whylinuxisbetter.net/
  [recover grub]: https://help.ubuntu.com/community/RecoveringUbuntuAfterInstallingWindows?action=show&redirect=RecoverGrub
  [.docx to work in OO]: http://www.sigmundvoid.com/?p=81
