swift-red-black
===============
A red-black tree implemented in Swift.

##Usage

Add `redblacktree.swift` to your project.

###Creating a tree

To create a tree, just initialize it like so

```
let tree = RedBlackTree<K,V>()
```
where `K` is your key type and `V` is the type of whatever data you want to store in each node. Any type `K` can be used as long as it conforms to the protocol `Comparable`, and any type `V` is acceptable. For example, if I wanted to store an array of strings in each node and use floats as keys, I would write
```
let tree = RedBlackTree<Float,[String]>()
```

###Insertion
To insert a new node into the tree, there are two methods available: `insertKey(key: K, data:V)` and `insertNode(nodeToInsert: RedBlackTreeNode<K,V>)`. 

The first doesn't require the manual construction of a node to insert. For example,
```
tree.insertKey(7.9, data: ["Hello","Yes","This","Is","Dog])
```
Note that the data parameter can be nil if you don't want the node to store data.

The second method, however, does require that you build a node manually. 
```
let nodeToInsert = RedBlackTreeNode<Float,[String]>(tree: tree)
nodeToInsert.key = 8.5
nodeToInsert.data = nil
tree.insertNode(nodeToInsert)
```

###Search
To find a node with a given key, just call the `findKey(key: K)` method.

```
let foundNode = tree.findKey(7.9)
//foundNode's data is ["Hello","Yes","This","Is","Dog]
let nonExistentNode = tree.findKey(100)
// nonExistentNode's value is nil
```
Note, if there are duplicates in the tree, there is no way to return them all. I'll probably add this if I need it, but until then, you can extend the data structure to traverse the *right* subtree of your node which you suspect contains duplicates to see if it does.

This repository contains a red-black tree implemented in Swift. The algorithms were taken straight out of [CLRS](http://en.wikipedia.org/wiki/Introduction_to_Algorithms). I haven't optimized it or written proper tests and some parts are still buggy (I plan to improve this library in the near future.) It's slow compared to C/C++, with 10,000 insertions taking ~20ms, 10,000 finds taking ~26ms, and 10,000 deletions taking ~20ms. I assume that this will only get better with future versions of the compiler.

With that said, it takes full advantage of Swift's generics, so as long as keys conform to the protocol `Comparable`, they can be used.
