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
btCreator.printTee()

preOrderTraverse(root: tree)
print("\n ------")
middleOrderTraverse(root: tree)
print("\n ------")
backOrderTraverse(root: tree)
print("\n ------")
levelOrderTraverse(root: tree)
print("\n ------")

print("BFS: ",Solution().levelOrder(tree))
print("DFS: ",Solution().preOrder(tree))
