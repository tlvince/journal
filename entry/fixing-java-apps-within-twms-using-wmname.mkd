title: Fixing Java apps within TWMs using wmname
date: 2009-03-18
abstract: How to fix Java "grey window" issues using wmname

If you've ever had to use a Java app within a tiling window manager like *dwm*,
you've probably come across `AWT_TOOLKIT=MToolkit`. As dwm's [man page][]
elegantly puts it, using this environment variable instructs Java to use an
older toolkit to "fix" issues with grey windows and other oddly behaved GUI
elements as a result of using XAWT.

However, in my experience, using MToolkit also produces inconsistencies, so
thankfully another method also exists: [wmname][]. Stumbling across this utility
within the [Problems with Java][wiki] page of awesome's wiki (and within their
[mailing list][]) this tool seems to fix the aforementioned problems.

Just download and compile the tiny app and have it launch within your `.xinitrc`
as so:

    wmname LG3D &

and Java apps should be working as normal again!

  [man page]: http://man.suckless.org/dwm/1/dwm "dwm online manual"
  [wmname]: http://tools.suckless.org/wmname "wmname homepage"
  [wiki]: http://awesome.naquadah.org/wiki/Problems_with_Java
  [mailing list]: http://article.gmane.org/gmane.comp.window-managers.awesome/3267
