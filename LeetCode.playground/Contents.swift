import UIKit

/*
 无重复字符的最长子串
 输入: "bbbbb"
 输出: 1
 解释: 因为无重复字符的最长子串是 "b"，所以其长度为 1。
 
 输入: "pwwkew"
 输出: 3
 解释: 因为无重复字符的最长子串是 "wke"，所以其长度为 3。
 请注意，你的答案必须是 子串 的长度，"pwke" 是一个子序列，不是子串。

 链接：https://leetcode-cn.com/problems/longest-substring-without-repeating-characters
 */

/*
 第一版解法
 使用数组每次都遍历找重复字符串，然后把前面的删除
 */
class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var cAry = [Character]()
        var maxLength = -1
        for i in 0..<s.count {
            let c = s[s.index(s.startIndex, offsetBy: i)]
            var location = -1
            for (i,v) in cAry.enumerated() {
                if c == v {
                    location = i
                    break
                }
            }
            if location >= 0 {
                cAry.removeSubrange(0...location)
            }
            cAry.append(c)
            maxLength = maxLength > cAry.count ? maxLength : cAry.count
        }
        return maxLength > cAry.count ? maxLength : cAry.count
    }
}

class Solution2 {
    func lengthOfLongestSubstring(_ s:String) -> Int {
        var hashTable = [Character:Int]()
        var start=0,end=0,length=0
        for (index,value) in s.enumerated() {
            if hashTable.keys.contains(value) {
                start = max(start, hashTable[value]! + 1)
            }
            end = index
            hashTable[value] = index
            length = max(length, end-start+1)
        }
        
        return length
    }
}
print(Solution().lengthOfLongestSubstring("abcabcbbxwwfsdfewrj4ew4rewfdsfvcdsr324324vscfdsfscdsfdsrew4e32"))
print(Solution2().lengthOfLongestSubstring("abcabcbbxwwfsdfewrj4ew4rewfdsfvcdsr324324vscfdsfscdsfdsrew4e32"))
