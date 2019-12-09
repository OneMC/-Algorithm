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


/*
 最长公共前缀。
 输入: ["flower","flow","flight"]
 输出: "fl"
 所有输入只包含小写字母 a-z 。
 链接：https://leetcode-cn.com/problems/longest-common-prefix
 */
class LongestPrefixSolution {
    func longestCommonPrefix(_ strs: [String]) -> String {
        var prefixAry = Array.init(strs.first!)
        for word in strs {
            for (index,value) in word.enumerated() {
                guard prefixAry.count > index  else {
                    break
                }
                if prefixAry[index] != value {
                    prefixAry.removeSubrange(index..<prefixAry.count)
                    break
                }
            }
        }
        return prefixAry.reduce("", { $0 + String.init($1) })
    }
}

LongestPrefixSolution().longestCommonPrefix(["flower","flow","flight"])

/*
 回文字符串
 */
extension Solution {
    func longestPalindrome(_ s: String) -> String {
        var start = INTMAX_MAX, end = INTMAX_MAX
        var i = INTMAX_MAX
        for (index,char) in s.enumerated() {
            if i == INTMAX_MAX {
                i = index
                continue
            }
            
            if char == s[i] {
                i -= 1
                if i < 0 {
                    start = 0
                    end = index
                }
                start = i
                end = index
            } else if char == s[i-1] {
                i -= 2
                start = i
                end = index
            } else {
                i = index
            }
        }
    }
}
