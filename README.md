Agents of W.I.K.I.M.E.D.I.A.
=========

A [Shiny application](http://shiny.rstudio.com/) for exploring the most commonly used user agents of Wikimedia
properties - both those used by editors, and those used by readers, distinguishing users of the mobile
and desktop sites.

__Authors:__ Oliver Keyes<br/>
__License:__ [MIT](http://opensource.org/licenses/MIT)<br/>
__Status:__ In development.

Description
======
A necessary prerequisite of good website design is understanding what browsers you will be expected to support. This is
best done by...well, looking at the browsers that are hitting your site.

Unfortunately user agents aren't exactly human-readable - which is why we have user-agent parsers. We can use them to
turn a long user agent into something actual humans can understand, and avoid unexpectedly distinguishing two instances
of the same browser with the same version but a different release number.

This project allows people - developers, readers, interested third-parties - to explore the most commonly-used browsers
on Wikimedia properties. It covers both readers and editors, and both the mobile and desktop sites. At the same time, we
are releasing the raw user agents for high-volume browsers, in the hope that upstream developers maintaining
such parsers will find them useful.

Datasets and reuse
======

The canonical form of the datasets is hosted on Figshare, and is released under the CC-0 public domain dedication.
It can be cited as:

> there will be a citation here soon.
