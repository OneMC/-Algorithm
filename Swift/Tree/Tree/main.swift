//
//  main.swift
//  Tree
//
//  Created by MC on 2019/11/15.
//  Copyright © 2019 MiaoChao. All rights reserved.
//

import Foundation

let btCreator = BTCreator()
let tree = btCreator.creatBT(height: 4)
print("\n ---origin Tree---")
btCreator.printTee()

print("\n ---Pre Order---")
preOrderTraverse(root: tree)
print("\n ---In Order---")
middleOrderTraverse(root: tree)
print("\n ---Post Order---")
backOrderTraverse(root: tree)
print("\n ---Layer Order---")
levelOrderTraverse(root: tree)

print("\n\n ---Leet Code---")
print("\n ---LC BFS---")
print("BFS: ",Solution().levelOrder(tree))
print("\n ---LC DFS---")
print("DFS: ",Solution().preOrder(tree))
