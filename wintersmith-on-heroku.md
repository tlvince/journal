```metadata
title: Wintersmith on Heroku
date: 2012-06-22
abstract: Efficiently serving generated static files using Connect
```

[Wintersmith][] is a static site generator written in Node. This post describes
two methods of hosting a Wintersmith-powered site on Heroku. Note, much of this
post is analogous to Matthew Manning's [write up][mm] for Jekyll/Ruby-powered
sites. Thanks Matthew.

We'll begin with how *not* to do it:

## Wintersmith's preview server on Heroku

The simplest method of serving a Wintersmith site is by using its built-in web
server. The [process model][pm] of Heroku's Cedar stack (now the default at the
time of writing) makes it really easy to get this up and running quickly.

If you haven't already, create a Heroku app:

```bash
heroku create -s cedar
```

Next, create a `package.json` file (at the root of your app), declaring
Wintersmith as a dependency:

```json
{
  "name": "node-example",
  "version": "0.0.1",
  "dependencies": {
    "wintersmith": "1.0.x"
  }
}
```

Next, write a [Procfile][] (again, at the root of your app), declaring
Wintersmith as the default web process type:

```
web: wintersmith preview --chdir public --port $PORT
```

... replacing `public` with the directory that contains your site.

Finally, deploy to Heroku and open up your new site in a browser:

```bash
git push heroku master
heroku open
```

## Serving static files with Connect

Whilst the previous method works, it is inefficient: in preview mode,
Wintersmith generates pages on the fly for *every* request. Instead, lets make
full use of Wintersmith's *build* option. Rather than generating pages on the
fly, the entire site is generated *once* as static HTML files. This way, not
only is the site much faster, we are free to choose any web server.

### Setting up Connect

Here we'll be using [Connect][] to stay within the Node/Javascript paradigm but
feel free to use something else (Rack/Thin might be a good option).

First add Connect to your `package.json` file:

```json
"dependencies": {
  "wintersmith": "1.0.x",
  "connect": "2.3.x"
}
```

... and install it with `npm install`. Also set the web process type (in
`Procfile`) as:

```
web: node server.js
```

### Connect server

Now we'll write a minimal web server using the Connect framework. Create a
`server.js` file (at the root of the project) containing the following:

```javascript
var connect = require('connect');
var port = process.env.PORT || 3000;
var oneDay = 86400000;

connect.createServer(
  connect.compress(),
  connect.logger('short'),
  connect.static(__dirname + '/build', { maxAge: oneDay })
).listen(port);
```

An important line here is `var port = process.env.PORT || 3000;` which respects
the `PORT` environment variable set by Heroku. Otherwise, the list of middleware
can customised; just refer to the [documentation][connect] and plug-and-play.
Remember to modify the `build` path to wherever you specify in the following
step.

### Heroku buildpack

Rather than committing the generated site to the repository, we'll instead hook
into Heroku's build phase using a custom [buildpack][]. Buildpacks compile our
code for execution on each deploy to Heroku.

I've [forked][buildpackws] the default Node.js buildpack, adding one addition to
the compile method: the buildpack will check for a `Makefile` in the project
root and call its default task (`all`) to generate the Wintersmith site.

Firstly, add the buildpack using:

```bash
heroku config:add BUILDPACK_URL="https://github.com/tlvince/heroku-buildpack-wintersmith.git#wintersmith"
```

... then create a `Makefile` containing the command used to build the site:

```
all:
  wintersmith build <path>
```

Any arbitrary shell commands can also be added to the task as necessary.

### Testing

Lets test the set up by first building the site using our `Makefile` and then
firing up the Connect server:

```bash
make
node server.js
```

If successful, you should see your blazingly fast site on
`http://localhost:3000`. Monitor the `node` output to confirm HTTP caching is
working correctly.

Finally, deploy to Heroku. You should see the line `Node.js: Wintersmith` in the
output, followed by `-----> Building Wintersmith site` in the build log.

  [mm]: http://www.mwmanning.com/2011/11/29/Run-Your-Jekyll-Site-On-Heroku.html
  [pm]: https://devcenter.heroku.com/articles/cedar#process_model
  [connect]: http://www.senchalabs.org/connect/
  [procfile]: https://devcenter.heroku.com/articles/procfile
  [buildpack]: https://devcenter.heroku.com/articles/buildpacks
  [buildpackws]: https://github.com/tlvince/heroku-buildpack-wintersmith/tree/wintersmith
  [wintersmith]: http://jnordberg.github.com/wintersmith/
