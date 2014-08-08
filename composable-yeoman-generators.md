```metadata
title: Composable Yeoman Generators
date: 2014-08-08 12:38:49 +0100
abstract: Programmatically call generators for reuse
```

Yeoman generator [v0.17.0][] included a useful new feature dubbed
[composability][]. If you've ever wanted to reuse generators by calling one from
another, this is the feature you've been waiting for. Here's a quick overview
of how you might use it.

## Creating a generator

Lets begin by creating a new generator. The Yeoman team have made it trivial to
get started via [generator-generator][], so lets fire it up:

```bash
npm install -g yo generator-generator
mkdir my-generator && cd my-generator
yo generator
cd generator-my-generator
```

*Note*, as of generator-generator v0.4.4, an older version of yeoman-generator
without composability support is used. So first confirm that
`"yeoman-generator": "~0.17.0"` is listed in `package.json` or update
accordingly.

generator-generator produces commonly used templates such as `.jshintrc` and
`.editorconfig` for us, but wouldn't it be nice if these were maintained
elsewhere? That's where [generator-common][] comes in.

## Composability

Here we'll use `composeWith` to programmatically call generator-common from our
new generator. Lets remove the pre-generated templates and methods:

```bash
rm -rf app/templates
```

*`app/index.js`*:

```js
'use strict';

var yeoman = require('yeoman-generator');

var MyGeneratorGenerator = yeoman.generators.Base.extend({
 // Prototype methods
});

module.exports = MyGeneratorGenerator;
```

By default, Yeoman calls every method in the generator's prototype in sequence.
So lets add a new method --- `templates` --- that calls generator-common:

```js
var MyGeneratorGenerator = yeoman.generators.Base.extend({
  templates: function() {
    this.composeWith('common', {});
  }
});
```

Lets give it a try:

```bash
npm link
yo my-generator
```

If you haven't previously installed generator-common, you'll likely be shown an
error similar to:

> You don't seem to have a generator with the name common installed.

By default, `composeWith` hooks into npm's [peerDependencies][] to resolve a
generator. (If you're not familiar, a peer dependency is one that is installed
as a sibling).

So lets indicate generator-common is a peer by appending it to `package.json`'s
`peerDependencies` block:

```json
"peerDependencies": {
  "yo": ">=1.0.0",
  "generator-common": ">=0.2.0"
}
```

*Note*, I've followed Yeoman's [recommendation][] of using a *higher or equal
to* version qualifier to prevent conflicts.

Lets install generator-common and give our generator another spin:

```bash
npm install -g generator-common
yo my-generator
```

All being well, you'll see Yeoman's noble face and your generated templates.

```
     _-----_
    |       |    .--------------------------.
    |--(o)--|    |   Welcome to the Yeoman  |
   `---------´   |     Common generator!    |
    ( _´U`_ )    '--------------------------'
    /___A___\
     |  ~  |
   __'.___.'__
 ´   `  |° ´ Y `

```

## Conclusion

We've barely scratched the surface of `composeWith`'s potential, but have
covered just enough to get you started. See Yeoman's [composability][]
documentation for further information and [tlvince/generator-my-generator][]
for this tutorial's source.

[v0.17.0]: https://github.com/yeoman/generator/releases/tag/v0.17.0-pre.1
[generator-generator]: https://github.com/yeoman/generator-generator
[generator-common]: https://github.com/eddiemonge/generator-common
[peerDependencies]: http://blog.nodejs.org/2013/02/07/peer-dependencies/
[recommendation]: https://github.com/yeoman/yeoman.io/blob/10aca980a4c0d5ea242ed22f3b2af32c95f45eae/app/authoring/composability.md#dependencies-or-peerdependencies
[composability]: http://yeoman.io/authoring/composability.html
[tlvince/generator-my-generator]: https://github.com/tlvince/generator-my-generator
