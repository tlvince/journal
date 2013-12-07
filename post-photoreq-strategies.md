```metadata
title: Post-PhotoRec Strategies
abstract: An overview of approaches to sort files recovered by PhotoRec
date: 2012-12-20
```

If you've ever been in the unfortunate situation where your hard disk fails
beyond recognition ([like mine did][background]), then you've likely come across
a low-level file recovery tool called [PhotoRec][].

PhotoRec does a fantastic job of recovering files by matching byte headers with
signatures of known file formats. At the time of writing, it recognises over
[440 file formats][formats], which covers just about every format you're likely
to encounter day-to-day.

However, the challenge *after* using PhotoRec is what to do with its output; the
unavoidable result of the data carving technique it uses is that the underlying
directory tree and file names are lost. You are therefore left with a flat-level
tree containing thousands of seemingly nonsensical files with file names such as
`f1191548088.txt`... Not particularly useful.

This post looks at a few approaches you can use to organise the recovered files.

  [background]: http://unix.stackexchange.com/questions/33284/recovering-ext4-superblocks
  [photorec]: http://www.cgsecurity.org/wiki/PhotoRec
  [formats]: http://www.cgsecurity.org/wiki/File_Formats_Recovered_By_PhotoRec

## Sorting strategies

Lets look at a few strategies to sort through the mess:

* <a href="#sort-by-file-extension">Sort by file extension</a>
* <a href="#hash-audit">Hash audit</a>
* <a href="#remove-corrupt-files">Remove corrupt files</a>
* <a href="#rename-using-metadata">Rename using metadata</a>

### Sort by file extension

PhotoRec's [After Using PhotoRec][after] wiki page lists a few methods to sort
files after using the tool. The mentioned Python script collates each file by
its file extension. Whilst by no means fully solving the problem, this method
can help in combination with other approaches. Although unlikely, this may also
be of use if the file system in use has a [maximum files per directory
limit][dirlimit], such as FAT32.

  [after]: http://www.cgsecurity.org/wiki/After_Using_PhotoRec#Sort_files_by_extension
  [dirlimit]: http://stackoverflow.com/a/466596

### Hash audit

[hashdeep][], a program that computes and matches hashsets, has an *audit*
function that can compare file hashes against a known set. If you have a
known-good backup, this can be an effective way to determine which files you
already have and then prune them from PhotoRec's set.

  [hashdeep]: http://md5deep.sourceforge.net

### Rename using metadata

A fortunate side-effect of using binary formats is that metadata is often saved
alongside its content. Depending on the format, a number of tools can be used to
re-organise the recovered file without reliance on file names.

#### Photos

In the case of photos, we can use the excellent [exiftool][] to rebuild a
directory tree based based on their timestamp:

```bash
exiftool -r '-FileName<CreateDate' -d %Y/%m/%Y%m%d_%H%M%S%%-c.%%e [files]
```

  [exiftool]: http://www.sno.phy.queensu.ca/~phil/exiftool/

#### Music

Music can be handled elegantly using [MusicBrainz Picard][picard]. For a given
audio file, it will use acoustic fingerprinting techniques to generate a hash of
said file and then query it against the MusicBrainz database to determine its
contents.

Be sure to read through Picard's [how-to guide][howto], particularly the
clustering function, which greatly speeds up the querying process. Also, at the
time of writing, the latest release of Picard (v1.2) contains a memory leak
which causes it to hang when dealing with large datasets. Try running the
[development version][picard-gh] (the issue is resolved in pull-requests
[#143][] and [#146][]) if you experience this.

Alternatively, many cloud-based music platforms such as Google Play Music or
iTunes have a "scan and match" feature (using similar fingerprinting
technologies as Picard), which will provide high bitrate, fully-tagged versions
of recognised files available to stream or re-download.

  [picard]: https://musicbrainz.org/doc/MusicBrainz_Picard
  [howto]: https://musicbrainz.org/doc/How_to_Tag_Files_With_Picard
  [picard-gh]: https://github.com/musicbrainz/picard
  [#143]: https://github.com/musicbrainz/picard/pull/143
  [#146]: https://github.com/musicbrainz/picard/pull/146

### Remove corrupt files

Unfortunately, there isn't a universal way of determining whether a file is
corrupt. However, depending on the importance of your recovered data, there are
a few approaches worth trying:

#### Photos

The [Python Imaging Library][pil] (PIL) contains a [verify method][verify]
(search for 'verify') that should catch obvious corruptions. After installing
PIL, try running Denilson Sá's `[jpeg_corrupt][]`, which is a thin
command-line-based wrapper around PIL's verify method; given a glob of input
paths, it prints the names of those *verify* determines as corrupt.

  [pil]: http://www.pythonware.com/products/pil/
  [verify]: http://effbot.org/imagingbook/image.htm
  [jpeg_corrupt]: https://bitbucket.org/denilsonsa/small_scripts/src/96af96e23bc1e19c9156412cdbb8eeba09e21cad/jpeg_corrupt.py

#### Photos/Videos

Running [ffmpeg][] without an output file parameter displays information about
the given file. If ffmpeg is unable to parse the file, it'll spit out a warning,
which can be leveraged to filter and delete corrupt files, e.g.:

```bash
ffmpeg -i "$i" 2>&1 | grep -q 'Invalid data found when processing input' && rm "$i"
```

  [ffmpeg]: http://ffmpeg.org
