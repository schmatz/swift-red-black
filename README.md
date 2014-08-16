swift-red-black
===============
A red-black tree implemented in Swift.

##Usage

Add `redblacktree.swift` to your project.

###Creating a tree

To create a tree, initialize it like so

```swift
let tree = RedBlackTree<K,V>()
```
where `K` is your key type and `V` is the type of whatever data you want to store in each node. Any type `K` can be used as long as it conforms to the protocol `Comparable`, and any type `V` is acceptable. For example, if I wanted to store an array of strings in each node and use floats as keys, I would write
```swift
let tree = RedBlackTree<Float,[String]>()
```

###Insertion
To insert a new node into the tree, there are two methods available: `insertKey(key: K, data:V)` and `insertNode(nodeToInsert: RedBlackTreeNode<K,V>)`. 

The first doesn't require the manual construction of a node to insert. For example,
```swift
tree.insertKey(7.9, data: ["Hello","Yes","This","Is","Dog"])
```
Note that the data parameter can be nil if you don't want the node to store data.

The second method, however, does require that you build a node manually. 
```swift
let nodeToInsert = RedBlackTreeNode<Float,[String]>(tree: tree)
nodeToInsert.key = 8.5
nodeToInsert.data = nil
tree.insertNode(nodeToInsert)
```

###Search
To find a node with a given key, call the `findKey(key: K)` method.

```swift
let foundNode = tree.findKey(7.9)
//foundNode's data is ["Hello","Yes","This","Is","Dog"]
let nonExistentNode = tree.findKey(100)
// nonExistentNode's value is nil
```
Note, if there are duplicates in the tree, there is no way to return them all. I'll probably add this if I need it, but until then, you can extend the data structure to traverse the *right* subtree of your node which you suspect contains duplicates to see if it does.

###Deletion
Like insertion, there are two functions to handle deletion, `deleteKey(key: K)` and `deleteNode(z: RedBlackTreeNode<K,V>)`. Again, if there are duplicates in the tree, it will only remove one at a time.

###Other methods
Some other methods are 
* `minimum(var rootNode: RedBlackTreeNode<K,V>) -> RedBlackTreeNode<K,V>`
  * Find the minimum node of the subtree rooted at `rootNode`
* `func maximum(var rootNode: RedBlackTreeNode<K,V>) -> RedBlackTreeNode<K,V>`
  * Find the maximum node of the subtree rooted at `rootNode`
* `successorOfNode(var node: RedBlackTreeNode<K,V>) -> RedBlackTreeNode<K,V>`
  * Find the node after `node` in an in-order traversal
* `func predecessorOfNode(var node: RedBlackTreeNode<K,V>) -> RedBlackTreeNode<K,V>`
  * Find the node before `node` in an in-order traversal

All of the other methods are private and have to do with rotations and tree repair.

###Notes

The algorithms used to implement this tree were taken straight out of [CLRS](http://en.wikipedia.org/wiki/Introduction_to_Algorithms). I haven't profiled this implementation, but I will in the future if performance becomes a problem; this tree is slow compared to ones implemented in C/C++, with 10,000 insertions taking ~20ms, 10,000 finds taking ~26ms, and 10,000 deletions taking ~20ms. I assume that this will only get better with future versions of the compiler. 

###License

The MIT License (MIT)

Copyright (c) 2014 Michael Schmatz

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

