//
//  main.swift
//  redblack
//
//  Created by Michael Schmatz on 8/15/14.
//  Copyright (c) 2014 MichaelSchmatz. All rights reserved.
//

import Foundation

var tree = RedBlackTree<Int,Int>()

func setup() {
  tree = RedBlackTree<Int,Int>()
}

func testInsertion() {
  setup()
  assert(tree.root === tree.sentinel)
  tree.insertKey(20, data: nil)
  assert(tree.root.key == 20)
  tree.insertKey(18, data :nil)
  assert(tree.root.left.key == 18)
  tree.insertKey(22, data :nil)
  assert(tree.root.right.key == 22)
  //Now force some rotations
  tree.insertKey(16, data: nil)
  assert(tree.root.left.left.key == 16)
  tree.insertKey(14, data: nil)
  //right rotation should have ocurred
  assert(tree.root.left.key == 16)
  assert(tree.root.left.left.key == 14)
  assert(tree.root.left.right.key == 18)
  tree.insertKey(24, data: nil)
  tree.insertKey(26, data: nil)
  //left rotation should have ocurred
  assert(tree.root.right.key == 24)
  assert(tree.root.right.left.key == 22)
  assert(tree.root.right.right.key == 26)
  //now test the colors (leaves should be red, interior nodes black)
  println("Insertion tests passed.")
}

func testDeletion() {
  setup()
  tree.insertKey(20, data: nil)
  tree.insertKey(18, data: nil)
  tree.insertKey(22, data: nil)
  tree.insertKey(16, data: nil)
  tree.insertKey(14, data: nil)
  tree.insertKey(24, data: nil)
  tree.insertKey(26, data: nil)
  //Delete the root and verify the state of the tree
  tree.deleteKey(20)
  assert(tree.root.key == 22)
  assert(tree.root.left.key == 16)
  assert(tree.root.left.left.key == 14)
  assert(tree.root.left.right.key == 18)
  assert(tree.root.right.key == 24)
  assert(tree.root.right.right.key == 26)
  assert(tree.root.right.left === tree.sentinel)
  //Delete the root again
  tree.deleteKey(22)
  assert(tree.root.key == 24)
  assert(tree.root.right.key == 26)
  //And again
  tree.deleteKey(24)
  assert(tree.root.key == 16)
  assert(tree.root.left.key == 14)
  assert(tree.root.right.key == 26)
  assert(tree.root.right.left.key == 18)
  //and again
  tree.deleteKey(16)
  assert(tree.root.key == 18)
  assert(tree.root.left.key == 14)
  assert(tree.root.right.key == 26)
  //and again
  tree.deleteKey(18)
  assert(tree.root.key == 26)
  assert(tree.root.left.key == 14)
  //and again
  tree.deleteKey(26)
  assert(tree.root.key == 14)
  assert(tree.root.right === tree.sentinel)
  assert(tree.root.left === tree.sentinel)
  assert(tree.root.parent === tree.sentinel)
  //and again
  tree.deleteKey(14)
  assert(tree.root === tree.sentinel)
  //Try deleting a nonexistent node
  tree.deleteKey(500)
  println("Deletion tests passed.")
}


testInsertion()
testDeletion()
