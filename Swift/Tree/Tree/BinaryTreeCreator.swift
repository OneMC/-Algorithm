//
//  BinaryTreeCreator.swift
//  Tree
//
//  Created by MC on 2019/11/18.
//  Copyright © 2019 MiaoChao. All rights reserved.
//

import Foundation

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

class BTCreator {
    var max:Int?
    let range:ClosedRange<Int>
    private var dic = Dictionary<Int,Array<Int>>()
    
    init(_ range:ClosedRange<Int> = 0...500) {
        self.range = range
    }
    
    func creatBT(height:Int) -> TreeNode {
        self.max = height
        let root = TreeNode(Int.random(in: self.range))
        self.dic[1] = [root.val]
        _createBT(root: root, level: 2)
        return root
    }
    
    func printTee() {
        for key in dic.keys.sorted() {
            print("\(key) : \(self.dic[key]!)")
        }
    }
    
    private func _createBT(root:TreeNode,level:Int) {
        if level > self.max! {
            return
        }
        
        let left = TreeNode(Int.random(in: self.range))
        root.left = left
        
        let right = TreeNode(Int.random(in: self.range))
        root.right = right
        
        var ary = self.dic[level] ?? Array<Int>()
        ary.append(left.val)
        ary.append(right.val)
        self.dic[level] = ary
        
        let currentLevel = level + 1
        _createBT(root: left, level: currentLevel)
        _createBT(root: right, level: currentLevel)
    }
}
