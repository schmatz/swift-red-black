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
  tree.insertKey(20)
  assert(tree.root.key == 20)
  tree.insertKey(18)
  assert(tree.root.left.key == 18)
  tree.insertKey(22)
  assert(tree.root.right.key == 22)
  //Now force some rotations
  tree.insertKey(16)
  assert(tree.root.left.left.key == 16)
  tree.insertKey(14)
  //right rotation should have ocurred
  assert(tree.root.left.key == 16)
  assert(tree.root.left.left.key == 14)
  assert(tree.root.left.right.key == 18)
  tree.insertKey(24)
  tree.insertKey(26)
  //left rotation should have ocurred
  assert(tree.root.right.key == 24)
  assert(tree.root.right.left.key == 22)
  assert(tree.root.right.right.key == 26)
  //now test the colors (leaves should be red, interior nodes black)
  assert(tree.root.red == false)
  assert(tree.root.right.red == false)
  assert(tree.root.left.red == false)
  assert(tree.root.left.left.red == true)
  assert(tree.root.left.right.red == true)
  assert(tree.root.right.left.red == true)
  assert(tree.root.right.right.red == true)
  println("Insertion tests passed.")
}

func testDeletion() {
  setup()
  tree.insertKey(20)
  tree.insertKey(18)
  tree.insertKey(22)
  tree.insertKey(16)
  tree.insertKey(14)
  tree.insertKey(24)
  tree.insertKey(26)
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
  assert(tree.root.red == false)
  assert(tree.root.left.red == false)
  assert(tree.root.right.red == false)
  //and again
  tree.deleteKey(18)
  assert(tree.root.key == 26)
  assert(tree.root.left.key == 14)
  assert(tree.root.red == false)
  assert(tree.root.left.red == true)
  //and again
  tree.deleteKey(26)
  assert(tree.root.key == 14)
  assert(tree.root.red == false)
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
