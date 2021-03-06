```metadata
title: Developers are users too!
date: 2011-03-29
abstract: A rant about user experience from a developers perspective
```

*Design for users* is an oft cited, well grounded mantra in programming circles.
However, us developers often forget about a principle user group: *other
developers*. This post details a typical, frustrating afternoon for a developer
dealing with new technologies.

## Fanboy

Here's the situation: I want to update Chromium's `userstyle` CSS file with the
latest Fanboy element hider rules. As hackers do, my first instinct is to write
a script to do it for me. A few lines of Python later, and I'm faced with this:

```python
Traceback (most recent call last):
  ...
urllib.error.URLError: <urlopen error [Errno 10060] A connection attempt failed
because the connected party did not properly respond after a period of time, or
established connection failed because connected host has failed to respond>
```

"Uh?! It must be that damn corporate firewall again." Now, I've seen this one
before and, armed with another script (to set up `cmd` with the correct proxy
settings... yes, I'm running Windows here), I try again... with no joy:

```python
File "C:\Python31\lib\http\client.py", line 684, in _tunnel
for header, value in self._tunnel_headers.iteritems():
AttributeError: 'dict' object has no attribute 'iteritems'
```

"I'll fix it later", I think as I copy/paste the file manually.

## YUI, You Eee?

"Hmm, I wonder if anyone's thought of minifying `userstyles`?" With Fanboy's CSS
file, being ~4500 lines, it can't be a bad idea. Having not used `yuicompressor`
for a year or so now, I thought I'd take a look to see where the development has
come since then.

The YUI Compressor homepage currently looks like this:

  [![YUI Compressor homepage][yuith]][yui]

  [yui]: /assets/img/2011-03-14_15-15-28.png
  [yuith]: /assets/img/th/2011-03-14_15-15-28.png

"OK, well, where's the download link". That's a screenshot in a Chromium app
window and still there's another 2/3'rds to go. Scanning amongst the wall of
text, I finally notice the unassuming download link:

  [![The well-hidden YUI compressor download link][yuidlth]][yuidl]

  [yuidl]: /assets/img/2011-03-14_15-35-58.png
  [yuidlth]: /assets/img/th/2011-03-14_15-35-58.png

Latest (presumedly stable) build was 2009?!

  [![YUI's last stable build was 2009][yuistth]][yuist]

  [yuist]: /assets/img/2011-03-14_15-39-17.png
  [yuistth]: /assets/img/th/2011-03-14_15-39-17.png

Oh, well, I've come this far, I might as well try it:

```java
java -jar yuicompressor-2.4.2.jar Custom.css

Exception in thread "main" java.lang.reflect.InvocationTargetException
        at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at sun.reflect.NativeMethodAccessorImpl.invoke(Unknown Source)
        at sun.reflect.DelegatingMethodAccessorImpl.invoke(Unknown Source)
        at java.lang.reflect.Method.invoke(Unknown Source)
        at com.yahoo.platform.yui.compressor.Bootstrap.main(Bootstrap.java:20)
Caused by: java.lang.IllegalArgumentException: Illegal group reference
        at java.util.regex.Matcher.appendReplacement(Unknown Source)
        at com.yahoo.platform.yui.compressor.CssCompressor.compress(CssCompressor.java:86)
        at com.yahoo.platform.yui.compressor.YUICompressor.main(YUICompressor.java:178)
        ... 5 more
```

"Damnnn it!".

## Squashing bugs

The first result of a Google for `yui InvocationTargetException` returns a [bug
report][yuibug], with a comment mentioning a fix(?) was committed in 2010. "OK,
fine. It's impossible to not notice the 'Fork me on GitHub' banner, so there
must be a newer build there."

"Damn, there are no pre-packaged builds. Nevermind, I'll try building myself."
Noticing the `build.xml` file, I head over to download Apache Ant. While, I've
never used `ant` before (I more versed with `make`), I know it's a mature
project, so things should go smoothly, right?

## Ant, err, Ivy

A quick Google for [apache ant][ivy] gives me those handy links to directly
jump to pages. "Hmm, what are those called again?"; [google sitelinks][gsl].
"Great! relevant-looking results".

  [![Google webmaster help pages][gwhpth]][gwhp]

  [gwhp]: /assets/img/2011-03-14_16-36-05.png
  [gwhpth]: /assets/img/th/2011-03-14_16-36-05.png

"This Help Centre is not currently available in your language." "Argh!!" Just
because I live in China, doesn't mean I can speak Chinese. Where's an English
fall-back option? Oh, forget it.

  [![The first result of a Google search for Apache Ant][gantth]][gant]

  [gant]: /assets/img/2011-03-14_16-41-54.png
  [gantth]: /assets/img/th/2011-03-14_16-41-54.png

Anyway, those links are called "mini sitelinks". Back to the [apache ant][ivy]
search... I want to download it, and oh, great, there's the download link
straight away.

  [![Arrow as a clear metaphor for download][antdlth]][antdl]

  [antdl]: /assets/img/2011-03-14_16-42-46.png
  [antdlth]: /assets/img/2011-03-14_16-42-46.png

Nice, a nice easy download link.

```java
java -jar ivy-2.2.0.jar
:: loading settings :: url = jar:file:/C:/Documents%20and%20Settings/user/My
%20Documents/dwn/unsorted/apache-ivy-2.2.0-bin-with-deps/apache-ivy-2.2.0/ivy-2.
2.0.jar!/org/apache/ivy/core/settings/ivysettings.xml
:: resolving dependencies :: org.apache.ivy#ivy;2.2.0
        confs: [core, httpclient, oro, vfs, sftp, standalone, ant, default, test
, source]
```

Zzz. About a minute later and nothing happend. "Resolving dependencies... Oh,
it's trying to download something." Firing up the aforementioned "cmd proxy
setter" script, but no, still nothing.

## Ant (round 2)

Something's up here. I'll rollback. Arbitrarily, I tried a [DDG search][ddg]
instead.

  [![Duck Duck Go's official site badge][ddgth]][ddg]

  [ddg]: /assets/img/2011-03-14_16-48-38.png
  [ddgth]: /assets/img/2011-03-14_16-48-38.png

Nice, an "official site" badge. I wonder how they determine that. Hmm,
this is looking different...

  [![Side-by-side view of the Apache Ant and Apache Ivy websites][antssth]][antss]

  [antss]: /assets/img/2011-03-14_16-52-32.png
  [antssth]: /assets/img/th/2011-03-14_16-52-32.png

Damn it! If this is `ant`, what did I just download? Pft, nevermind. Proceed to
the download link.

  [![Apache Ant's download sidebar][antside]][antside]

  [antside]: /assets/img/2011-03-14_16-54-13.png

Good, nice and easy. Moving on...

```dos
ant
Unable to locate tools.jar. Expected to find it in C:\Program Files\Java\jre6\li
b\tools.jar
Buildfile: build.xml does not exist!
Build failed
```

Huh?! "Build failed"? I just wanted to see if it'll run okay. And what's this
Java error? You didn't mention anything about Java.

```dos
ant -h
Unable to locate tools.jar. Expected to find it in C:\Program Files\Java\jre6\li
b\tools.jar
ant [options] [target [target2 [target3] ...]]
Options:
  ...
  -buildfile <file>      use given buildfile
    -file    <file>              ''
    -f       <file>              ''
  ...
```

Hmm, seems like an option to specify the `build.xml` location (though, isn't
that what `[target]` is?). Anyway, let's try that:

```java
ant -buildfile "C:\Documents and Settings\user\My Doc
uments\dwn\unsorted\yuicompressor-2.4.2\yuicompressor-2.4.2\build.xml"
Unable to locate tools.jar. Expected to find it in C:\Program Files\Java\jre6\li
b\tools.jar
Buildfile: C:\Documents and Settings\user\My Documents\dwn\unsorted\yuicompr
essor-2.4.2\yuicompressor-2.4.2\build.xml

-load.properties:

-init:

build.classes:
    [javac] C:\Documents and Settings\user\My Documents\dwn\unsorted\yuicomp
ressor-2.4.2\yuicompressor-2.4.2\build.xml:23: warning: 'includeantruntime' was
not set, defaulting to build.sysclasspath=last; set to false for repeatable buil
ds

BUILD FAILED
C:\Documents and Settings\user\My Documents\dwn\unsorted\yuicompressor-2.4.2
\yuicompressor-2.4.2\build.xml:23: Unable to find a javac compiler;
com.sun.tools.javac.Main is not on the classpath.
Perhaps JAVA_HOME does not point to the JDK.
It is currently set to "C:\Program Files\Java\jre6"

Total time: 0 seconds
```

**BUILD FAILED**. Ah, *now* you tell me that I explicitly need JDK.

## The Draconian Admin

OK (beleaguered by this point), let's grab JDK.

  [![Insufficient privileges error message from the Java installer][jdkth]][jdk]

  [jdk]: /assets/img/2011-03-14_17-26-28.png
  [jdkth]: /assets/img/th/2011-03-14_17-26-28.png

Despite my efforts (oh yes, *yes*, I *tried*), there's no getting round this
one.

## Closing Points

Things don't have be this hard! Design for users, yes, but don't neglect fellow
developers. Writing an API? Always prefer simple, well defined interfaces.
Laboriously writing documentation for the sake of busywork? Stop. Rethink your
design. It can always be simpler.

Developers are users too.

  [yuibug]: http://yuilibrary.com/projects/yuicompressor/ticket/2528046
  [ivy]: https://encrypted.google.com/search?hl=en&q=apache+ant
  [gsl]: https://encrypted.google.com/search?hl=en&q=google+sitelinks
  [ddg]: https://duckduckgo.com/?q=apache+ant&ke=-1&kh=1&k&ko=s&kr=c&ka=n&kk=l
