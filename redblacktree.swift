//
//  redblacktree.swift
//
//  Created by Michael Schmatz on 8/15/14.
//  Copyright (c) 2014 Michael Schmatz. All rights reserved.
//

public class RedBlackTreeNode<K: Comparable, V> {
  private var red: Bool = false
  public var key: K! = nil
  public var data:  V? = nil
  var right:  RedBlackTreeNode<K,V>!
  var left:  RedBlackTreeNode<K,V>!
  var parent:  RedBlackTreeNode<K,V>!
  
  init(sentinel: RedBlackTreeNode<K, V>) {
    right = sentinel
    left = sentinel
    parent = sentinel
  }
  
  init() {
    //This method is here to support the creation of a sentinel
  }
  
}

public class RedBlackTree<K: Comparable, V> {
  var root: RedBlackTreeNode<K,V>
  let sentinel: RedBlackTreeNode<K,V>
  
  init() {
    sentinel = RedBlackTreeNode<K,V>()
    sentinel.red = false
    root = sentinel
  }
  
  public func insertKey(key: K, data:V) {
    let newNode = RedBlackTreeNode<K,V>(sentinel:  sentinel)
    newNode.key = key
    newNode.data = data
    insertNode(newNode)
  }
  
  public func deleteKey(key: K) {
    let nodeToDelete = findNode(rootNode: root, key:  key)
    if nodeToDelete !== sentinel {
      deleteNode(nodeToDelete)
    }
  }
  
  public func findKey(key: K) -> RedBlackTreeNode<K,V> {
    return findNode(rootNode: root, key: key)
  }
  
  public func minimum(var rootNode: RedBlackTreeNode<K,V>) -> RedBlackTreeNode<K,V> {
    while rootNode.left !== sentinel {
      rootNode = rootNode.left
    }
    return rootNode
  }
  
  public func maximum(var rootNode: RedBlackTreeNode<K,V>) -> RedBlackTreeNode<K,V> {
    while rootNode.right !== sentinel {
      rootNode = rootNode.right
    }
    return rootNode
  }
  
  public func findNode(var #rootNode: RedBlackTreeNode<K,V>, key: K) -> RedBlackTreeNode<K,V> {
    while rootNode !== sentinel && key != rootNode.key {
      if key < rootNode.key {
        rootNode = rootNode.left
      } else {
        rootNode = rootNode.right
      }
    }
    return rootNode
  }
  
  public func successorOfNode(var node: RedBlackTreeNode<K,V>) -> RedBlackTreeNode<K,V> {
    if node.right !== sentinel {
      return minimum(node.right)
    }
    var successor = node.parent
    while successor !== sentinel && node === successor.right {
      node = successor
      successor = successor.parent
    }
    return successor
  }
  
  public func predecessorOfNode(var node: RedBlackTreeNode<K,V>) -> RedBlackTreeNode<K,V> {
    if node.left !== sentinel {
      return minimum(node.left)
    }
    var successor = node.parent
    while successor !== sentinel && node === successor.left {
      node = successor
      successor = successor.parent
    }
    return successor
  }

  public func insertNode(nodeToInsert: RedBlackTreeNode<K,V>) {
    var y = sentinel
    var x = root
    while x !== sentinel {
      y = x
      if nodeToInsert.key < x.key {
        x = x.left
      } else {
        x = x.right
      }
    }
    nodeToInsert.parent = y
    if y === sentinel {
      root = nodeToInsert
    } else if nodeToInsert.key < y.key {
      y.left = nodeToInsert
    } else {
      y.right = nodeToInsert
    }
    nodeToInsert.left = sentinel
    nodeToInsert.right = sentinel
    nodeToInsert.red = true
    insertFixup(nodeToInsert)
  }
  
  public func deleteNode(z: RedBlackTreeNode<K,V>) {
    var y = z
    var originallyRed = y.red
    var x: RedBlackTreeNode<K,V>!
    if z.left === sentinel {
      x = z.right
      transplant(z, v:  z.right)
    } else if z.right === sentinel {
      x = z.left
      transplant(z, v:  z.left)
    } else {
      y = minimum(z.right)
      originallyRed = y.red
      x = y.right
      if y.parent === z {
        x.parent = y
      } else {
        transplant(y, v:  y.right)
        y.right = z.right
        y.right.parent = y
      }
      transplant(z, v:  y)
      y.left = z.left
      y.left.parent = y
      y.red = z.red
    }
    if originallyRed == false {
      deletionFixup(x)
    }
  }
  
  private func insertFixup(var nodeToInsert: RedBlackTreeNode<K,V>) {
    while nodeToInsert.parent.red {
      if nodeToInsert.parent === nodeToInsert.parent.parent.left {
        var y = nodeToInsert.parent.parent.right
        if y.red {
          nodeToInsert.parent.red = false
          y.red = false
          nodeToInsert.parent.parent.red = true
          nodeToInsert = nodeToInsert.parent.parent
        } else {
          if nodeToInsert === nodeToInsert.parent.right {
            nodeToInsert = nodeToInsert.parent
            leftRotate(nodeToInsert)
          }
          nodeToInsert.parent.red = false
          nodeToInsert.parent.parent.red = true
          rightRotate(nodeToInsert.parent.parent)
        }
      } else {
        var y = nodeToInsert.parent.parent.left
        if y.red {
          nodeToInsert.parent.red = false
          y.red = false
          nodeToInsert.parent.parent.red = true
          nodeToInsert = nodeToInsert.parent.parent
        } else {
          if nodeToInsert === nodeToInsert.parent.left {
            nodeToInsert = nodeToInsert.parent
            rightRotate(nodeToInsert)
          }
          nodeToInsert.parent.red = false
          nodeToInsert.parent.parent.red = true
          leftRotate(nodeToInsert.parent.parent)
        }
      }
    }
    root.red = false
  }
  
  private func deletionFixup(var x: RedBlackTreeNode<K,V>) {
    while x !== root && x.red == false {
      if x === x.parent.left {
        var w = x.parent.right
        if w.red == true {
          w.red = false
          x.parent.red = true
          leftRotate(x.parent)
          w = x.parent.right
        }
        if w.left.red == false && w.right.red == false {
          w.red = true
          x = x.parent
        } else {
          if w.right.red == false {
            w.left.red = false
            w.red = true
            rightRotate(w)
            w = x.parent.right
          }
          w.red = x.parent.red
          x.parent.red = false
          w.right.red = false
          leftRotate(x.parent)
          x = root
      }
    } else {
        var w = x.parent.left
        if w.red == true {
          w.red = false
          x.parent.red = true
          rightRotate(x.parent)
          w = x.parent.left
        }
        if w.right.red == false && w.left.red == false {
          w.red = true
          x = x.parent
        } else {
          if w.left.red == false {
            w.right.red = false
            w.red = true
            leftRotate(w)
            w = x.parent.left
          }
          w.red = x.parent.red
          x.parent.red = false
          w.left.red = false
          rightRotate(x.parent)
          x = root
        }
      }
    }
    x.red = false
  }
  
  private func rightRotate(oldSubtreeRoot: RedBlackTreeNode<K,V>) {
    let newSubtreeRoot = oldSubtreeRoot.left
    oldSubtreeRoot.left = newSubtreeRoot.right //reassign g
    if newSubtreeRoot.right !== sentinel {
      newSubtreeRoot.right.parent = oldSubtreeRoot //reassign g's parent
    }
    newSubtreeRoot.parent = oldSubtreeRoot.parent //reassign the subtree's parent
    if oldSubtreeRoot.parent === sentinel { //if the root is the root of the tree
      root = newSubtreeRoot
    } else if oldSubtreeRoot === oldSubtreeRoot.parent.right { //reassign the original root parent's child node
      oldSubtreeRoot.parent.right = newSubtreeRoot
    } else {
      oldSubtreeRoot.parent.left = newSubtreeRoot
    }
    //establish parent/child relationship between old and new root nodes
    newSubtreeRoot.right = oldSubtreeRoot
    oldSubtreeRoot.parent = newSubtreeRoot
  }
  
  private func leftRotate(oldSubtreeRoot: RedBlackTreeNode<K,V>) {
    let newSubtreeRoot = oldSubtreeRoot.right
    oldSubtreeRoot.right = newSubtreeRoot.left
    if newSubtreeRoot.left !== sentinel {
      newSubtreeRoot.left.parent = oldSubtreeRoot
    }
    newSubtreeRoot.parent = oldSubtreeRoot.parent
    if oldSubtreeRoot.parent === sentinel {
      root = newSubtreeRoot
    } else if oldSubtreeRoot === oldSubtreeRoot.parent.left {
      oldSubtreeRoot.parent.left = newSubtreeRoot
    } else {
      oldSubtreeRoot.parent.right = newSubtreeRoot
    }
    newSubtreeRoot.left = oldSubtreeRoot
    oldSubtreeRoot.parent = newSubtreeRoot
  }
  
  private func transplant(u: RedBlackTreeNode<K,V>, v: RedBlackTreeNode<K,V>) {
    //Swaps two subtrees
    if u.parent === sentinel {
      root = v
    } else if u === u.parent.left {
      u.parent.left = v
    } else {
      u.parent.right = v
    }
    v.parent = u.parent
  }
  
}
