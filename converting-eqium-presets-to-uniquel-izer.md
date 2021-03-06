```metadata
title: Converting Eqium Presets To UNIQUEL-IZER
date: 2008-02-27
abstract: Hacking Eqium XML files
```

Since [Elemental Audio][1] have changed hands to [Roger Nichols Digital, Inc][2],
all their original plugins, such as Eqium and Firium have changed name and been
given slight updates (mainly just the inclusion of a few extra
presets).

Eqium is now known as UNIQUEL-IZER and Firium known as FREQUAL-IZER.

But what if, after "upgrading", you want to use your original nicely crafted
presets? Unfortunately, the new plugins use new preset formats and won't load
your originals. However, I was looking at the preset files to Equim, opened them
up in Notepad2 and all they are standard XML files. I made a preset with the new
plugin and they share the same XML format. Luckily, just updating the header and
end element labels and changing the file extension of the old presets solves the
issue.

Here's an example:

```xml
<!--2002 Elemental Audio Systems, www.elementalaudio.com-->
<uniquelizer_filter_settings version="Roger Nichols Digital UNIQUEL-IZER Settings v1.0">
[INSERT .eqm source here]
</uniquelizer_filter_settings>
```

  [1]: http://www.elementalaudio.com/
  [2]: http://www.rogernicholsdigital.com/
