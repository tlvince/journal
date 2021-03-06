```metadata
title: Static commenting
date: 2012-10-19 16:52:22 +0800
abstract: A review of static commenting solutions for static website generators
```

Static website generators typically rely on third-parties to provide commenting
services. This post introduces *static commenting* as an alternative and
reviews existing solutions.

## Background

Comments are an oft-neglected facet of static website generators. Typically,
they are outsourced to third-parties (Disqus [et al][disqus]., social networks
and news websites) or are simply [switched off][comments off].

Whilst the [pros][three reasons] and [cons][harmful] of the aforementioned are
well-documented, the middle-ground --- a commenting system that doesn't rely on
a third-party that's suitable for static websites --- is not. Lets call this
*static commenting* and explore its characteristics.

## Static commenting

What constitutes a good static commenting approach? Here are a few
possibilities:

* Adheres to the *progressive enhancement* strategy (doesn't rely on JavaScript)
* Uses a *plain-text* data store
* Integrates well with existing static website generators

With these criteria in mind, the remainder of this post reviews existing
approaches to static commenting.

### Jekyll Static Comments

[Jekyll::StaticComments][jekyll-static] ([source on
Github][jekyll-static-source]), uses a HTML form and a PHP submission script
that emails comments to a given address. Comments are then converted to YAML
format using a mail user agent (MUA) hook and rendered in the site with example
templates.

Whilst not entirely static (a server running PHP is required), a nice
side-effect of this approach is spam is implicitly dealt with by existing email
anti-spam technique(s) (whether that's your email provider's spam protection or
[otherwise][anti-spam]).

One drawback could be the level of manual intervention involved. Although the
author does not specify the exact details of the MUA hook, the process appears
to be only partially automated and favours hand-moderation.

However, derivatives that provide further automation are easily achievable. [As
the author mentions][jekyll-static-auto], the PHP script could be modified to
automatically commit the comment to a `git` repository and, with [further
hooks][jekyll-deployment], rebuild the site.

The MUA hook is central to the suggested workflow. A mail client that supports
hooks/external scripting (such as Mutt) is therefore a prerequisite for this
approach. The alternative (copy/pasting the email) is unlikely to be attractive
for web mail users or email clients less command-line orientated.

That said, the suggested workflow is only one example; the script itself does
not force it and is flexible to accommodate other approaches. For example,
email rules could be set up that automatically forward the comment for
deployment.

Alternatively, as the author mentions (in comment of the blog post), email
could be removed entirely by having the PHP script dump each comment on a
server for the moderator to periodically download and review. Further still,
integration with [Akismet][] could produce a Wordpress-like, fully automated
system.

### Emailed comments

[Tomas Carnecky][emailed-comments] takes Jekyll Static Comment's approach one
further: removing the form and PHP components and asking commenters to email
directly.

Linkage between page and comment is provided using a `mailto:` link composed of
a `comment+` prefix (plus addressing) and the page identifier (typically its
path). The emails are then processed in the same way as Jekyll Static Comments;
using a MUA hook.

This rather ingenious use of `mailto:` can easily be integrated in existing
templates and therefore is truly static; no plugins or server required.

It could be argued that sending an email rather than writing in a form
disconnects the commenter from the website somewhat. Also, loading an email
client just to leave a short comment (for example) may deter some users.

On the other hand, the user will already by well acquainted with the writing
environment provided by an email client (which are typically better suited than
a plain input box). Second, most modern browsers can associate `mailto:`
handlers with webmail clients, minimising loading time friction.

### The rest

Other approaches that don't meet the criteria of static commenting though may
be of interest include [PyBlosxom][]; a well-matured Python blogging engine
that ships with a [comment plugin][pyblosxom-comments] but sadly does not work
with static rendering, [Juvia][]; an open-source commenting service similar to
Disqus which depends on JavaScript and [NoNonsense Forum][nononsense]; which,
as the name implies, is more a standalone forum but makes novel use of RSS as a
data store.

## Conclusion

This post set out to explore alternatives to third-party commenting services
that are suitable for static website generators.

Despite best efforts, only two approaches were found; the first using a
traditional PHP-powered form, the second being email-based and using specially
purposed `mailto:` links.

A review of both approaches was given and extensions to the former offered.

  [disqus]: http://alternativeto.net/software/disqus/
  [comments off]: http://mattgemmell.com/2011/11/29/comments-off/
  [harmful]: http://www.jeremyscheff.com/2011/08/jekyll-and-other-static-site-generators-are-currently-harmful-to-the-free-open-source-software-movement/
  [three reasons]: http://avc.blogs.com/a_vc/2008/05/three-reasons-t.html

  [jekyll-static]: http://theshed.hezmatt.org/jekyll-static-comments/
  [jekyll-static-blog]: http://hezmatt.org/~mpalmer/blog/2011/07/19/static-comments-in-jekyll.html
  [jekyll-static-source]: https://github.com/mpalmer/jekyll-static-comments
  [jekyll-static-auto]: http://hezmatt.org/~mpalmer/blog/2011/07/19/static-comments-in-jekyll.html#fnref:comment-antispam
  [anti-spam]: https://en.m.wikipedia.org/wiki/Anti_spam
  [jekyll-deployment]: https://github.com/mojombo/jekyll/wiki/Deployment
  [akismet]: https://en.m.wikipedia.org/wiki/Akismet

  [emailed-comments]: https://blog.caurea.org/2012/03/31/this-blog-has-comments-again.html

  [pyblosxom]: http://pyblosxom.github.com/
  [pyblosxom-comments]: http://pyblosxom.github.com/1.5/plugins/comments.html
  [juvia]: https://github.com/phusion/juvia
  [nononsense]: http://camendesign.com/code/nononsense_forum
