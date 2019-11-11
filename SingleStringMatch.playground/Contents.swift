/*
 单字符串匹配算法
 解决的问题：从一个长度为n的主串中寻找长度为m模式串所在的位置。
 1. BF(Brute Force)算法，也叫暴力匹配或朴素的模式匹配；
 2. RF(Rabin-Karp)算法；
 3. BM(Boyer-Moore)算法；
 4. KMP算法；
 */

/*
 1. BF(Brute Force)算法，也叫暴力匹配或朴素的模式匹配
 解释：从主串的第一个字符开始匹配，直到n-m停止；
 时间复杂度：O(n*m)
 在字符串长度较小的情况下，首选该算法。
 */
func bfMatch(main:String, pattern:String) -> Int {
    var ret = -1
    for i in main.indices {
        ret = i.encodedOffset
        for j in pattern.indices {
            if pattern[j] != main[main.index(i, offsetBy: j.encodedOffset)] {
                ret = -1
                break
            }
        }
        if ret != -1 {
            break
        }
    }
    return ret;
}
print("brute force : ", bfMatch(main: "abcffffwerwr", pattern: "bcf"))

/*
 2. RF(Rabin-Karp)算法
 原理：
 找出主串中所有与模式串长度相同的子串，并计算出这些子串的hash。然后通过hash来对比找到匹配的字符串。
 核心是Hash算法：从sub[i-1]的hash值通过算法获得到sub[i]的hash值。那么该方法时间复杂度是O(n)。
 空间复杂度更高：因为该算法有一个hash表。
 这里为了简化，就用系统方法获取子串的hash值；
 时间复杂度：
 最好情况的时间复杂度是O(n)，遍历算hash则时间复杂度就退化成了O(n*m)；
 */
func rfMatch(main:String, pattern:String) -> Int {
    let hashTable = subStringHashTable(content: main, patternLength: pattern.count)
    return hashTable[Substring(pattern)] ?? -1;
}
// 关键是构建hashtable，这里用的是最原始的O(n*m)时间复杂度的算法
func subStringHashTable(content:String, patternLength:Int) -> Dictionary<Substring,Int> {
    var hash = Dictionary<Substring,Int>()
    var cursor = content.startIndex
    while cursor.encodedOffset < content.count-patternLength {
        let index = content.index(cursor, offsetBy: patternLength)
        let sub = content[cursor..<index]
        hash[sub] = cursor.encodedOffset
        cursor = content.index(after: cursor)
    }
    return hash
}
print("rf : ",rfMatch(main: "abcffffwerwr", pattern: "bcf"))

/*
 3. BM(Boyer-Moore)算法
 原理：
 遇到不匹配字符时，向后x位再匹配，而不像暴力匹配下每次后移一位。算是暴力匹配模式的“剪枝”算法。
 1: 模式串是从后往前比较。如遇到不匹配字符，前面未匹配的字符就可丢弃，同时可以算出往后移的位数。
 2: 坏字符：移动位置 = 模式串当前匹配的位置-坏字符所在模式串的最后位置；如果为负数则用“好后缀”规则；
 3: 好后缀：移动位置 = 整个后缀在模式串中的最后位置；如果找不到则看好后缀后缀子串中是否有匹配的前缀；
 4: 好前缀：移动位置 = “好后缀”中与模式串前缀匹配的最长的后缀子；
 
 移动距离=Max{“坏字符”距离，“好后缀&好前缀”距离}
 
 核心：
 处理模式串得到三个hash表：
 1. 每个字符在模式串中的位置：hash[x]=locationNum;
 2. 每个长度的后缀子串在模式串的位置：suffix[length]=locationNum;
 3. 每个长度的后缀子串是模式串的前缀：prefix[length]=locationNum;
 其中最难处理的获得suffix和prefix数组；
 */
func bmMatch(main:String, pattern:String) -> Int {
    var ret = -1
    let badCTable = bmBadCharacter(content: pattern)
    let (suffixTable,prefixTable) = bmGoodSuffix(content: pattern)
    print(badCTable)
    print(suffixTable)
    print(prefixTable)
    
    func getDistance(mp:Int,pp:Int) -> Int {
        // bad Character distance
        let bdc = main[main.index(main.startIndex, offsetBy: mp)]
        var bcDis = -1
        if let bdcLocation = badCTable[bdc] {
            bcDis = pattern.count - pp - 1 - bdcLocation
        }
        
        print("bad char distance:",bcDis)
        
        // good Suffix distance
        let gsLocation = suffixTable[pp] ?? -1
        
        var gsDis = -1
        if gsLocation < 0 {
            for i in (0...pp).reversed() {
                if let temp = prefixTable[i], temp == true {
                    gsDis = pattern.count - i
                    print("good prefix distance:",gsDis)
                    break;
                }
            }
        } else {
            gsDis = gsLocation < 0 ? -1 : (pattern.count - gsLocation - pp)
            print("good suffix distance:",gsDis)
        }
        
        let dis = max(bcDis, gsDis)
        let ret = dis <= 0 ? pattern.count : dis
        print("move distance :",ret)
        return ret
    }
    
    var i = pattern.count-1
    while i < main.count {
        var allMatch = false
        for j in 0..<pattern.count {
            let cInMain = main[main.index(main.startIndex, offsetBy: i-j)]
            let cInPattern = pattern[pattern.index(pattern.endIndex, offsetBy: -(j+1))]
            print("main:",cInMain," pattern:",cInPattern)
            if cInMain != cInPattern  {
                allMatch = false
                i += getDistance(mp: i - j, pp: j)
                break;
            } else {
                allMatch = true
            }
        }
        if allMatch {
            ret = i - (pattern.count - 1)
            break
        }
    }
    return ret;
}

/// 计算每个字符在模式串中的位置，重复字符保留最后一个字符的位置
func bmBadCharacter(content:String) -> Dictionary<Character,Int> {
    var hashTable = [Character:Int]()
    for i in content.indices {
        hashTable[content[i]] = i.encodedOffset
    }
    return hashTable
}

/// 计算suffix和prefix数组
/// return (suffix,prefix)
func bmGoodSuffix(content:String) -> ([Int:Int],[Int:Bool]) {
    var suffix = [Int:Int]()
    var prefix = [Int:Bool]()
    
    for cursor in 0..<content.count-1{
        var k = 0
        while cursor-k >= 0 && content[content.index(content.startIndex, offsetBy: cursor-k)] ==
            content[content.index(content.endIndex, offsetBy:-(k+1))] {
                suffix[k+1] = cursor-k
                k += 1
        }
        if cursor-k < 0 {
            prefix[cursor+1] = true
        }
    }
    return (suffix,prefix)
}
print("BM : ", bmMatch(main: "xacssccabcfdsf234dsf234abcabcabcxyz", pattern: "cabcab"))
