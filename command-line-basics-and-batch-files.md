```metadata
title: Command Line Basics & Batch Files
date: 2007-07-25
abstract: An overview of the Windows command line
```

### Old File Names and Relative Paths

Dos paths use old 8.3 file names, so if any path contains a space, you
will have to find out the 8.3 version or enclose the whole path in
double quotes. 8.3 file names and paths can be found by using `dir /x` in
command prompt, e.g.:

```dos
cmd.exe
cd \
dir /x
Volume in drive C is Home
Volume Serial Number is BC55-A8B4
Directory of C:\
27/12/2005 01:19 0         AUTOEXEC.BAT
27/12/2005 01:19 0         CONFIG.SYS
24/07/2007 19:21
DOWNLO~1 Downloads
2 File(s) 0 bytes
1 Dir(s) 12,983,218,176 bytes free
```

`DOWNLO~1` is the 8.3 path name of the folder Downloads. Full paths that
include spaces need to be enclosed by double quotes (`""`), e.g.

```dos
cmd.exe
cd "Downloads\My Received Files"
C:\Downloads\My Received Files>
```

### The CD Command

The CD command changes the current active directory. It allows you to
move into one directory to another. For example, if you wanted to move
the Windows directory, you would type:

```dos
cd Windows
```

If you are currently in the Windows directory and wanted to go inside a
subdirectory, you would type:

```dos
cd System
```

Because Windows was the active directory, no other commands are needed.
But if you knew you wanted to move to a subdirectory of a directory
immediately you use a back slash (`\`). So the command would be: cd
Parent Directory\Subdirectory e.g.

```dos
cd Windows\System
C:\Windows\System>
```

This is called moving into a "deep" directory. If however, you were
already in a deep directory and wanted to move directly to a folder that
is nearer to the root, you can include an initial back slash (`\`). This
tells the CD command to move to the root of the drive first.

```dos
C:\Downloads\My Received Files>
cd \Windows\System
C:\Windows\System>
```

### Relative Paths & Parent Folders

So far, we've looked at moving forward in the folder (directory) tree.
You can also move backwards, or "Up", in exactly the same way as "Up One
Level" we're familiar with in the Windows GUI environment. Typing two
dots (`..`) move's up one level. This is used in the same way as Relative
URLs in HTML. Typing one dot (`.`) refers to the current directory You can
return to the root of the drive by typing a back slash (`\`) Relative
paths can be used with the CD command as before and can be strung
together like usual, e.g.

```dos
cmd.exe
C:\Documents and Settings\Tom>
cd ..\..
C:\>
```

Relative paths are a useful way of saving time when navigating between
folders, but are good to implement in folders that can have changing
paths. For example, if a person installs a game, they can install the
game to a different directory than default. If a configuration file is
nested within the games folders and the games folder tree remains
intact, relative paths can be used in the config's to point, for
example, to an exe that is in the games root folder, i.e.

```dos
D:\Quake 3\Servers\2vs2.bat
cd ..
START Quake3.exe
```

### Running A Batch File That Closes The CMD Window

Normally, whenever you run a batch file, if a program is called to
launch in the batch, the command prompt will stay running and doesn't
close until the program has closed. Adding an EXIT command to the end of
the batch file is suppose to end it, but "it is important to realize
that if a batch file or program is still running a program, the MS-DOS
windows will not close until it has completed. Therefore a MS-DOS window
may remain open either because the program stopped responding or because
it's still performing tasks." One way of closing the command window
before the program has closed is to call the program with the START
command, e.g.

```dos
@ ECHO OFF
D:
cd "D:\Games\Quake 3
START Quake3.exe
```

If the exe file contains a space, it's corresponding 8.1 filename will
have to be used, e.g.

```dos
@ ECHO OFF
D:
cd "D:\Games\Quake 3"
START Quake3~1.exe
```

Or it is possible to "trick" the START command by typing empty double
quotes before the exe and then enclosing the exe in it's own double
quotes:

```dos
@ ECHO OFF
D:
cd "D:\Games\Quake 3"
START "" "Quake 3.exe"
```

(Usually, the empty double quotes would be used to give the command
prompt's window a title)

### Copying The Contents Of CMD To Clipboard

In Windows XP, right click the command prompt window and press "Mark".
Now click and highlight the text you want copied and press enter.

### Some useful Commands

* `Cmd /k` --- Keeps the command box up
* `Tskill  /a` --- Kills the task
* `Net Start` --- Starts a service
* `Net Stop` --- Stops a service
* `rmdir /s` --- Deletes a folder
* `shutdown -s -f -t 10` --- Shutdown PC
