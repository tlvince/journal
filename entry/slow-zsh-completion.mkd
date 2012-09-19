title: Fixing slow Zsh command completion
date: 2011-04-05
abstract: How to disable hostname completion in Zsh

Zsh's command completion for some commands is unacceptably slow. After a bit of
digging, I discovered using an atypically large hosts file causes problems.
A one-line customisation to Zsh solved the issue.

## Problem

Tab completion on certain commands causes Zsh to use ~100% CPU time, rendering
the system unresponsive.

## Solution

Add the following to your `.zshrc` file:

    # Disable hostname completion
    zstyle ':completion:*' hosts off

## Background

Whenever I'd use tab completion on commands such as `git pull`, `rsync` and
`ssh`, my system would completely freeze. Zsh's advanced command completion is
one of it's killer features, so rather than switching back to Bash, this *had*
to be fixed.

A few unsuccessful DuckDuckGo[^1] searches later, I headed to the Zsh IRC
channel. One helpful user (thanks *daethorian*!) mentioned similar experiences
and alluded to the `/etc/hosts` file.

As mentioned in a [previous post][1], I use a custom hosts file as a lightweight
alternative to browser ad-blocking. Unfortunately, this file is necessarily huge
(~12,000 lines!), so it made sense for Zsh to die a slow death when trying to
match a hostname.

The idea was to disable hostname completion. With a bit of perseverance with
the [zshcompsys(1)][2] manual, I came up with:

    zstyle ':completion:*' hosts off

`:completion:*` matches any context where tab completion can be used (any
command, path, glob etc). `hosts` --- the "tag" (or type of completion) ---
accepts one parameter; either a path to a hosts file (defaulting to
`/etc/hosts`) or a boolean.

  [^1]: [DuckDuckGo][3] is a nice alternative to Google. I particularly like the
        zero-click information, https url rewrites and the !bang syntax. Check
        it out!

  [1]: /hosts-adblock
  [2]: https://duckduckgo.com/?q=!man+zshcompsys
  [3]: https://duckduckgo.com/?q=zsh+tab+completion+slow
