```metadata
title: Local music scrobbling with mpd
date: 2010-09-28
abstract: Logging plays from mpd to a file using mpdscribble
```

A [feature request][] recently [implemented][] in mpdscribble allows plays from
[mpd][] to be logged to file. If you already use Last.fm but like the idea of
being in control of your private data, this might be of interest.

First, why would you want to do this? I would consider music listening data
*private* data. It is a representation of you as a person, disclosing your
tastes, interests and perhaps whether you [pirate music][cbs].

[Last.fm][] is a great web service, principally offering music recommendation
that *actually works*. The trouble is, users (usually without knowing any
better) are happy to give away ownership of their data to be used by services
they have no control over. Worse still, the data is typically personally
identifiable by collecting IP addresses, mapped to public profile data. All in
all, it's bad news for privacy and a haven for [data mining][eff].

It's pretty bleak, but it's good to know there are other options to consider
(though, sorry to the non-Linux users; the rest of this article probably isn't
for you).

Logging to a file
-----------------

Using [mpdscribble][], we can now log listening habits to a plain-text file, the
most [guaranteed and ubiquitous format there is][philo]. An obvious use-case is
to provide statistical reports similar to how Last.fm does it, but also simply
to track what we play and when we played it.

### mpdscribble setup

1. Install `mpdscribble-git`
2. Add the following to your `~/.mpdscribble/mpdscribble.conf`:

```ini
[local]
file = /home/[user]/.cache/mpd/plays.log
```

That takes care of all future plays, but what about existing data?

Exporting Last.fm plays
-----------------------

Being a Last.fm user since 4 Aug 2006 (with 6617 plays, an average of 4 tracks
per day... or so it tells me), they already have a large chunk of my listening
data. Wouldn't it be nice to export the data into a format similar to that of
`mpdscribble`'s output?

I thought so, but remember, my data is now *their data* and they have no
obligations to offer this service. However, some nice use of the Last.fm API
provides a solution:

### LastToLibre

[LastToLibre][] is a collection of Python scripts "... to create a dump of your
Last.fm tracks and [import] them to Libre.fm". Usefully, this creates an
intermediary plain-text file in the format:

```
date  trackname  artistname  albumname  trackmbid  artistmbid  albummbid
```

... which can easily be reused for our purpose. I wrote a small Python3 script
to do exactly that:

#### lastexport2mpd.py

```python
#!/usr/bin/python3
# lastexport2mpd.py
# Copyright 2010 Tom Vincent <http://www.tlvince.com/contact/>

import os
import sys
import time

file = sys.path[0] + "/exported_tracks.txt"

with open(file) as tracks:
    with open(sys.path[0] + "/mpd-formatted-tracks.txt", mode='w', encoding='utf-8') as outFile:
        for line in tracks:
            timestamp, track, artist, album, trackmbid, artistmbid, albummbid = line.strip("\n").split("\t")
            timestamp = time.strftime("%Y-%m-%dT%H:%M:%SZ", time.localtime(int(timestamp)))
            outFile.write(timestamp + " " + artist + " - " + track + "\n")
```

Just put your `exported_tracks.txt` file in the same folder as
`lastexport2mpd.py` and grab `mpd-formatted-tracks.txt` once it's finished.

### mpdcron

We could have also used [mpdcron][]'s stats module for this. It keeps a log of
your plays and stores them into an sqlite database, but also includes a tool --
`homescrape` ---  that pulls in your Last.fm data and subsequently updates each
matching track's play count.

Prior to learning about LastToLibre above, I wrote *another* Python script to
export the `mpdcron` database to a format that mimics the output from
`mpdscribble`:

#### eugene2plain

```python
#!/usr/bin/python3
# eugene2plain.py
# Copyright 2010 Tom Vincent <http://www.tlvince.com/contact/>

import os
import sqlite3

DB = os.path.expanduser("~") + "/.mpdcron/stats.db"
OUT = os.path.expanduser("~") + "/plays.log"
PREFIX = "1970-01-01T00:00:00Z"

conn = sqlite3.connect(DB)
c = conn.cursor()
c.execute("SELECT artist,title,play_count FROM song WHERE play_count !='0'")
songs = (c.fetchall())

with open(OUT, mode='w', encoding='utf-8') as outFile:
    for song in songs:
        for i in range(int(song[2])):
            outFile.write(PREFIX + " " + song[0] + " - " + song[1] + "\n")
    conn.close
```

The Unix epoch *prefix* is used here since timestamps aren't imported by
`homescrape`.

Here're some brief usage notes:

1. Install `mpdcron`, `ruby`, `ruby-nokogiri`
2. `$ homescrape [username]`
3. `$ python3 eugene2txt.py`
4. `$ cat ~/.cache/mpd/plays.log >> ~/plays.log`
5. `$ mv ~/plays.log ~/.cache/mpd/`

So... now what?
---------------

Now your free to do more with your listening data. Send it off to Last.fm and
make a [poster][] out of it, join the free alternative [Libre.fm][] or just keep
it private and do cool things like:

```bash
cut -f2- -d ' ' ~/.cache/mpd/plays.log | uniq | wc -l
```

:)

  [mpdcron]: http://alip.github.com/mpdcron/ "mpdcron homepage on GitHub"
  [coreutils]: http://en.wikipedia.org/wiki/Coreutils "Wikipedia article on GNU Coreutils"
  [poster]: http://lastgraph.aeracode.org/about/posters/ "LastGraph Last.fm playing history posters"
  [Libre.fm]: http://libre.fm/ "Libre.fm homepage"
  [Last.fm]: http://last.fm/ "Last.fm homepage"
  [mpdscribble]: http://mpd.wikia.com/wiki/Client:Mpdscribble "The mpd Last.fm scrobbler homepage"
  [cbs]: http://techcrunch.com/2009/02/20/did-lastfm-just-hand-over-user-listening-data-to-the-riaa/ "The infamous Techcrunch/Last.fm data leakage rumour"
  [eff]: http://www.eff.org/deeplinks/2009/02/last-fm-and-the-diabolical-power-of-data-mining "Electronic Frontier Foundation on Last.fm data mining"
  [philo]: http://en.wikipedia.org/wiki/Unix_philosophy#McIlroy:_A_Quarter_Century_of_Unix "Wikipedia article on the Unix Philosophy"
  [LastToLibre]: http://bugs.libre.fm/wiki/LastToLibre "LastToLibre Last.fm export scripts"
  [feature request]: http://www.musicpd.org/mantis/view.php?id=3033 "mpdscribble bug tracker"
  [implemented]: http://git.musicpd.org/cgit/master/mpdscribble.git/commit/?id=ee72953d93b967b665dbc7447ffbaf5d9ffec324 "The mpdscribble git commit that implements the local logging feature"
  [mpd]: http://mpd.wikia.com/ "Music Player Daemon Community Wiki"
