//
//  LeetCode.swift
//  Tree
//
//  Created by MC on 2019/11/18.
//  Copyright © 2019 MiaoChao. All rights reserved.
//

import Foundation

/*
 102题：二叉树按层遍历，并将结果输出到如下数组中
 [[3],
  [9,20],
  [15,7]]
 https://leetcode-cn.com/problems/binary-tree-level-order-traversal/
*/

/*
 102 levelOrder BFS
 该题有与普通的层序遍历不同的是需要判断一层有多少个元素；
 处理方式则是在在内层再加一层循环，每次开始时队列的数目就是该层的元素数
 */
class Solution {
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var ret = [[Int]]()
        guard root != nil else {
            return ret
        }
        var queue = [TreeNode]()
        queue.append(root!)
        
        while queue.count > 0 {
            let levelLength = queue.count
            var temp = [Int]()
            for _ in 0..<levelLength {
                let node = queue.removeFirst()
                temp.append(node.val)
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
            ret.append(temp)
        }
        return ret
    }
}

/*
 102 PreOrder DFS
 深度遍历时需要有一个level来表示当前是第几层，然后通过level将元素添加到对应的数组中
 */
extension Solution {
    func preOrder(_ root: TreeNode?) -> [[Int]] {
        var ret = [[Int]]()
        guard root != nil else {
            return ret
        }
        _preOrderDfs(root, 0, &ret)
        return ret
    }
    
    func _preOrderDfs(_ root: TreeNode?, _ level:Int, _ ret: inout [[Int]]) {
        guard root != nil else {
            return
        }
        
        var temp = ret.count > level ? ret[level] : [Int]()
        temp.append(root!.val)
        if ret.count > level {
            ret[level] = temp
        } else {
            ret.append(temp)
        }
        
        let nextLevel = level + 1
        _preOrderDfs(root!.left, nextLevel,&ret)
        _preOrderDfs(root!.right, nextLevel,&ret)
    }
}

/*
 226 翻转二叉树
 https://leetcode-cn.com/problems/invert-binary-tree/
 */
extension Solution {
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        guard root != nil else {
            return root
        }
        let temp = root!.left
        root!.left = root!.right
        root!.right = temp
        
        _ = invertTree(root!.left)
        _ = invertTree(root!.right)
        return root
    }
}
