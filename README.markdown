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

## Installation

    gem install onix

## Usage

See files in the examples directory to get started quickly. For further reading
view the comments to the following classes:

* ONIX::Reader - For reading ONIX files
* ONIX::Writer - For writing ONIX files
* ONIX::Normaliser - For normalising ONIX files before reading them. Fixes encoding issues, etc

## Licensing

This library is distributed under the terms of the MIT License. See the included file for
more detail.

## Contributing

All suggestions and patches welcome, preferably via a git repository I can pull from.
To be honest, I'm not really expecting any, this is a niche library.

## Further Reading

- The source: [http://github.com/yob/onix/tree/master](http://github.com/yob/onix/tree/master)
- The official specs [http://www.editeur.org/8/ONIX/](http://www.editeur.org/8/ONIX/)
