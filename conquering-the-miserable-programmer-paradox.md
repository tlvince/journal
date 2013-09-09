```metadata
title: Conquering the miserable programmer paradox
date: 2011-01-22
abstract: A productivity hack to overcome rote work
```

All too commonly, people work on things they despise. Programmers are no
different, especially since computers are particularly suited to repetitive
tasks. I experienced it recently but devised a challenge helped me overcome
it.

Problem
-------

I was recently given a task so monotonous, it would make any programmer
[miserable][]. I was asked to check a series of stock codes to find which were
singularly-listed (i.e. listed on only one stock exchange). Presented with 160
rows of Excel data, I was expected to search Reuters for each stock code,
one-by-one *by hand*.

Having experienced similar soul-destroying data entry work in previous
employment, with half a Computer Science degree under my belt, I took a
different route and wrote an algorithm to do the work for me. [Work smart, not
hard][smart].

Solution
--------

I took the task and devised a way of making it interesting. I challenged myself
to write an algorithm, using full [test-driven development][tdd] (TDD)
principles, in a language I have little experience with (Python 3), all **within
one hour**.

After clarifying the requirements, I outlined the core algorithm on paper. I'd
save time by manually copy/pasting the stock codes into a plain-text file and
reading in each to query against Reuters. Closer inspection of the Reuters page
showed a redirect occurred when the stock was singularly listed. I therefore
planned to listen for the 301/302 HTTP redirect code on each request and log
each triggering stock to a file.

Reflection
----------

### On productivity

Like most software projects, mine was late: one hour turned into *three*. The
fabricated estimate did however do wonders for my concentration; **time pressure
is an awesome productivity tool**.

It may have taken longer, but the large majority of those three hours were of
solid focus; "wired in" as it's known in [The Social Network][fb].

### On scheduling

*Note*, this was three hours of *elapsed time* (rather than sole keyboard
bashing). Why? Because "how do you account for interruptions, unpredictable
bugs [and] status meetings..."? [You can't, really][esp].

Only the people who actually write the code --- the developers --- can estimate
how long a task will take, *but* only by recording honest [velocity][] (the
division of the estimate by the actual time spent) do the developer's estimates
hold any weight. Experience makes you a better estimator.

### On Python 3

Without going into too much depth, Python 3's library module for requesting web
pages --- `urllib.request` --- has it's limitations. Since redirect responses are
[silently ignored][fancy], I found a mature third-party module --- `httplib2`
--- to overcome this.

Despite strong praise in [Dive Into Python 3][dip3] (DIP3, my main and excellent
resource for learning Python 3), I ran into a few bugs that prevented me from
using it. I lost around 1.5 hours troubleshooting, settling instead to redesign
my algorithm to scrape the Reuters page, compromising increased complexity for
`urllib.request` support.

Python 3 is a very clean and expressional language, but as the author of DIP3
[reminds us][pilgrim], it's still very much in active development, with a low
adoption rate (so far) over Python 2.

### On workflows

Having a customised, pre-configured setup particularly helped when the pressure
was on. Everything was at hand --- windows managed by [xmonad][], complete editing
efficiency with [vim][], rounded off with continuous integration testing using
[nosier][] --- helping me concentrate on the task at hand.

TDD is worthwhile methodology, effectively capturing your thought process as
formal specifications. It gives you confidence your code works and is robust
enough to withstand changes.

Writing tests --- *good tests* --- is a real art however. Your tests should
**cover corner cases** and be easily **repetable**, with new tests **only** being
written **when existing code passes**.

In reality, mine were narrow and couldn't provide anything more than a small
inkling of assurance.

  [miserable]: http://blog.garlicsim.org/post/2840398276/the-miserable-programmer-paradox
  [smart]: https://secure.wikimedia.org/wikipedia/en/wiki/Work_smart
  [tdd]: https://secure.wikimedia.org/wikipedia/en/wiki/Test-driven_development
  [esp]: http://www.joelonsoftware.com/items/2007/10/26.html
  [velocity]: https://secure.wikimedia.org/wikipedia/en/wiki/Velocity_(software_methodology)
  [fb]: https://secure.wikimedia.org/wikipedia/en/wiki/The_social_network
  [pilgrim]: http://www.reddit.com/r/IAmA/comments/f545e/i_am_a_fourtime_published_author_i_write_free/c1dcgsm
  [fancy]: http://docs.python.org/py3k/library/urllib.request.html?highlight=urllib#urllib.request.FancyURLopener
  [dip3]: http://diveintopython3.org/http-web-services.html#introducing-httplib2
  [xmonad]: http://xmonad.org/
  [vim]: http://www.vim.org/
  [nosier]: http://pypi.python.org/pypi/nosier
