
# html views

A HTML templating DSL and management system. 

## Motivation

I wanted to build a view system that could be used by lightweight web frameworks
that would be more powerful and less burdensome than ad-hoc methods or calling
out to a text file based template engine.

## Features

- HTML DSL
- layout system (common site containing code goes here)
- nested views (views can render sub views)
- variables can be passed into views as needed
- HTML5 tags

## Installation

Unfortunatly html-views is not yet in QuickLisp so you have to git clone this
repo into your ${QUICKLISP}/local-projects directory and then just
(ql:quickload :cl-html-views) or add cl-html-views to your system definitions.

## Basic usage

See the examples folder for a walkthrough.

## How it works

Basically the method defview is a macro that generates a bunch of macros that turn
your code into a bunch of princ statements. It uses only one stream so it should
be fast. This code is then wrapped in a lambda and handed to a hash table. Render
then calls up these methods, passing them a stream and presto- sexp to string
conversion with view nesting and what not.

## Disclaimer

I am not by any stretch a lisp expert. I have been hacking lisp in my spare time
for less than a year. This code works as well as I have tested it but I have
not put it through any real work (I wrote this so I could do real work in lisp).
So the techniques employed may make your stomach turn if you look too closely.

## Future features

- view caching. render complex sub views once.
- some logic so if you invoke a tag with no arguments you can skip the extra 'nil'.
- pretty printing the html output for easier debugging
- more complex example code such as pulling things out of a DB.
- ability to render to a provided stream rather than just text

## License stuff

By me (Ivan Kocienski) in 2015. Released under the MIT License.