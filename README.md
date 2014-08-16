Swift Red-Black Tree
===============

This repository contains a red-black tree implemented in Swift. The algorithms were taken straight out of [CLRS](http://en.wikipedia.org/wiki/Introduction_to_Algorithms). I haven't optimized it or written proper tests and some parts are still buggy (I plan to improve this library in the near future.) It's slow compared to C/C++, with 10,000 insertions taking ~20ms, 10,000 finds taking ~26ms, and 10,000 deletions taking ~20ms. I assume that this will only get better with future versions of the compiler.

With that said, it takes full advantage of Swift's generics, so as long as keys conform to the protocol `Comparable`, they can be used.
