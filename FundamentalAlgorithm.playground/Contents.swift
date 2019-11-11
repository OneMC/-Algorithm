import UIKit
class Node {
    var value:Int
    var next:Node? = nil
    init(_ val: Int) {
        self.value = val
    }
}

/*
 翻转单链表
 */
func reverseLinkNode(_ head:Node) -> Node {
    var previous:Node? = nil
    var current:Node? = head
    while current != nil {
        let next = current!.next
        current!.next = previous
        previous = current
        current = next
    }
    return previous!
}

/*
 链表两两翻转
 */
func reversePairLinkNode(_ head:Node) -> Node {
    var pHead:Node? = head
    var pFollow = head.next
    var previous:Node? = nil
    
    let newHead = head.next ?? head
    
    while pFollow != nil {
        // 两节点翻转
        pHead!.next = pFollow?.next
        pFollow?.next = pHead
        
        if previous != nil {
            previous!.next = pFollow
        }
        
        previous = pHead
        pHead = pHead?.next
        pFollow = pHead?.next
    }
    return newHead
}

/*
 Linked Node Test
 */
func createLinkNode() -> Node {
    let head = Node.init(41)
    var current = head
    
    for _ in 0...Int.random(in: 5...10) {
        let node = Node.init(Int.random(in: 5...100))
        current.next = node
        current = node
    }
    return head
}

func printLink(head:Node) {
    var current:Node? = head
    
    while current != nil {
        print(current!.value)
        current = current!.next
    }
}

let link = createLinkNode()
printLink(head: link)
print("------")
printLink(head: reverseLinkNode(link))
printLink(head: reversePairLinkNode(link))
// ======================================================================

/*
 翻转二叉树
 */
