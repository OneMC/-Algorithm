//
//  Traversal.swift
//  Tree
//
//  Created by MC on 2019/11/18.
//  Copyright © 2019 MiaoChao. All rights reserved.
//

import Foundation

/*
 二叉树中的DFS也就是前中后序遍历
 */

/// 前序遍历
/// root, leftTree, rightTree
func preOrderTraverse(root:TreeNode?) {
    if root == nil {
        return
    }
    print(" \(root!.val)",terminator: "")
    preOrderTraverse(root: root!.left)
    preOrderTraverse(root: root!.right)
}


/// 中序遍历
/// left tree, root, right tree
func middleOrderTraverse(root:TreeNode?) {
    if root == nil {
        return
    }
    middleOrderTraverse(root: root!.left)
    print(" \(root!.val)",terminator: "")
    middleOrderTraverse(root: root!.right)
}

/// 后序遍历
/// left tree, right tree, root
func backOrderTraverse(root:TreeNode?) {
    if root == nil {
        return
    }
    
    backOrderTraverse(root: root!.left)
    backOrderTraverse(root: root!.right)
    print(" \(root!.val)",terminator: "")
}

/// 层序遍历也就是BFS（广度优先搜索）
func levelOrderTraverse(root:TreeNode) {
    var queue = [TreeNode]()
    queue.append(root)
    while queue.count > 0 {
        let node = queue.removeFirst()
        print(" \(node.val)",terminator:"")
        if let left = node.left {
            queue.append(left)
        }
        if let right = node.right {
            queue.append(right)
        }
    }
}
