## ONIX

The ONIX standard is a somewhat verbose XML format that is rapidly becoming the
industry standard for electronic data sharing in the book and publishing
industries.

This library provides a slim layer over the format and simplifies both reading
and writing ONIX files in your ruby applications.

This replaces the obsolete rbook-onix gem that was spectacular in its crapness.
Let us never speak of it again.

## Feature Support

This library currently only handles ONIX 2.1 files (all revisions). At some
point I'll need to work out what to do about supporting ONIX 3.0 files. I
suspect a separate library will be the simplest solution.

ONIX::Reader only handles the reference tag versions of ONIX 2.1. Use
ONIX::Normaliser to convert any short tag files to reference tags.

ONIX::Writer only generates reference tag ONIX files.

It baffles me why anyone thought designing two parallel versions of the ONIX
spec was a good idea. Use reference tags my friends, and let short tags fade
away into irrelevant obscurity.

## DTD Loading

To correctly handle named entities when reading an ONIX file, this gem attempts
to load the DTD describing the ONIX format into memory. By default, this means
each file you read will require several hundred Kb of data to be downloaded
over the net.

This is obviously not desirable in most cases. To avoid it, you need to add copies
of the ONIX DTDs into your system XML catalog. On Debian and Ubuntu systems,
the quickest way to do that is to build and install the package available @
http://github.com/yob/onix-dtd

## Installation

    gem install onix

## Usage

See files in the examples directory to get started quickly. For further reading
view the comments to the following classes:

* ONIX::Reader - For reading ONIX files
* ONIX::Writer - For writing ONIX files
* ONIX::Normaliser - For normalising ONIX files before reading them. Fixes encoding issues, etc
* ONIX::Lists  - For building hashes of code lists from the ONIX spec

## Licensing

This library is distributed under the terms of the MIT License. See the included file for
more detail.

## Contributing

All suggestions and patches welcome, preferably via a git repository I can pull from.
To be honest, I'm not really expecting any, this is a niche library.

## Further Reading

- The source: [http://github.com/yob/onix/tree/master](http://github.com/yob/onix/tree/master)
- The official specs [http://www.editeur.org/8/ONIX/](http://www.editeur.org/8/ONIX/)
