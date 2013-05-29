Underscore.js Utilities as NoFlo Components [![Build Status](https://secure.travis-ci.org/kenhkan/noflo-underscore.png?branch=master)](https://travis-ci.org/kenhkan/noflo-underscore)
===============================

This module contains simple proxies of
[Underscore.js](http://underscorejs.org/) functions.

Feel free to contribute new components and graphs! I'll try to
incorporate as soon as time allows.


Usage
-------------------------------

### GroupBy ###

It works exactly like `_.groupBy` and accepts individual packets, which
are converted into an array at an `endgroup` or a `disconnect` to be
forwarded with `_.groupBy` applied on it.

#### In-ports

  * IN: packets each to be grouped by a property
  * PROPERTY: the property to group the packets by

#### Out-ports

  * OUT: the grouped object

#### Examples

Grouping by length of strings:

    'length' -> PROPERTY GroupBy(underscore/GroupBy)
    '1\n2\n3' -> IN SplitA(core/SplitStr) OUT -> IN GroupBy() OUT -> IN Output(core/Output)
