title: xmonad
abstract: My usage notes for the Haskell-based tiling window manager
date: 2009-11-21

[xmonad][] is an excellent tiling window manager (TWM) written in Haskell.
Following my [review of TWM's][review] and publication of my [config
repository][xmonad-config], this post details my usage of xmonad.

## Contrib extensions

"Contrib" contains a library of extra functionality to plug into xmonad. There's 
a whole lot in there, so I will be discussing some of the modules most useful to 
my workflow.

### Prompt

The prompt namespace of modules contains a library for displaying input prompts.

#### xmonad.Prompt.RunOrRaise

Similar to `dmenu`. Advantages over `dmenu` are:

* Displayed on your currently active screen rather than where mouse focus is
* Tab-completion

By design, its *raise* feature also doubles up to provide functionality similar 
to `xmonad.Prompt.Window`'s `Bring` option (albeit listing everything in `$PATH` 
rather than just the running windows).

I bind this to `xK_f` --- analogous to "find".

#### xmonad.Prompt.Window

Similar to my `wmctrl` script, this either brings the selected window to your 
current workspace or switches to the workspace the window is running in.

I find `Bring` the most useful option here.

## Further reading

I recommend reading Braden Shepherdson's [Pimp Your xmonad][pimp] series for
further inspiration.

  [pimp]: http://braincrater.wordpress.com/2008/11/02/pimp-your-xmonad-1-status-bars/
  [xmonad]: http://xmonad.org/
  [review]: http://tlvince.com/tiling-window-managers-reprise
  [xmonad-config]: https://github.com/tlvince/xmonad-config
