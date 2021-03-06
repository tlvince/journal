```metadata
title: Persnickety design
date: 2012-12-11 20:44:45 +0000
abstract: A brief look at the typographical details of my site
```

"Web Design is 95% Typography" [they say][95%]... and I tend to agree. This
post looks at how improved my site's typography using a Node.js module and
closes with a remark on CSS hyphenation.

## Typography

Like [Steve Losh][losh], the underlying goal of my site (in terms of design) is
minimalism. I use little-to-no images, a large font and a narrow measure. This
text-centric "[text as a user interface][text-ui]" approach is intended to make
my site a pleasure to read without tools like Readability.

Behind the curtains, all content of this site is written in Markdown and parsed
as HTML using [marked][]. Whilst marked is a fantastic parser, it (currently)
does not support any typographical-enhancing extensions, such as those provided
by [SmartyPants][]. Enter *typogr.js*.

[typogr.js][] is a small Node library with the aim to do one thing and to do it
well: apply transformations on plain text to yield typographically-improved
HTML. It can apply a raft of typographical filters besides those provided by
SmartyPants. See its [API][] for more details.

After [a few][open-pulls] [patches][pulls], I use typogr.js throughout this
site. Besides smart quotes and correct use of [en- and em-dashes][dashes],
ordinals are styled to match `sup` tags (such as those used on a post's
[authored date][date]), the imposition of block capitals (such as "API") is
reduced to match surrounding body text and [widows][] (lines containing only a
single word) are eliminated through careful placement of `&nbsp;`.

## A bleak aside on hyphenation

As with the last iteration of this site, I was keen to use hyphenation.
Previously, I was using [hyphenator][], which, all-in-all, works rather well.
However, since this iteration *proudly* uses zero Javascript, I preferred a CSS
approach.

Alas, although CSS3's hyphenation [works wonderfully in Firefox][css-hyphens],
webkit has yet to catch up. I toyed with enabling it regardless, but as [Divya
Manian states][h5bp-hyphens], hyphens without justified text
*reduces* readability.

Besides conditionally setting justified text via CSS browser hacks, native
support for hyphenation *and* justified text is *still* impractical as of 2012.
Lets hope 2013 is the year of the hyphen.

  [95%]: http://informationarchitects.net/blog/the-web-is-all-about-typography-period/
  [losh]: http://stevelosh.com/blog/2010/09/making-my-site-sing/#finding-a-starting-point
  [text-ui]: http://informationarchitects.net/blog/the-web-is-all-about-typography-period/
  [marked]: https://github.com/chjj/marked
  [smartypants]: http://daringfireball.net/projects/smartypants/
  [typogr.js]: https://github.com/ekalinin/typogr.js
  [api]: https://github.com/ekalinin/typogr.js#api
  [open-pulls]: https://github.com/ekalinin/typogr.js/pulls/tlvince
  [pulls]: https://github.com/ekalinin/typogr.js/pulls/tlvince?direction=desc&page=1&sort=created&state=closed
  [date]: /persnickety-design#date-authored
  [dashes]: http://www.smashingmagazine.com/2011/08/15/mind-your-en-and-em-dashes-typographic-etiquette/
  [widows]: https://en.wikipedia.org/wiki/Widow_(typesetting)
  [hyphenator]: https://code.google.com/p/hyphenator/
  [css-hyphens]: http://caniuse.com/css-hyphens
  [h5bp-hyphens]: https://github.com/h5bp/html5-boilerplate/issues/708#issuecomment-1861631
