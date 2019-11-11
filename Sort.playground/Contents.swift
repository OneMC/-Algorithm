import UIKit
func quickSort( array:inout [Int],left:Int,right:Int) {
    if array.count < 2 || right - left < 1{
        return
    }
    
    let baseNum = array[left]
    var leftCurosr = left
    var rightCurosr = right
    
    while leftCurosr < rightCurosr {
        while array[rightCurosr] >= baseNum && leftCurosr < rightCurosr {
            rightCurosr -= 1
        }
        while array[leftCurosr] <= baseNum && leftCurosr < rightCurosr {
            leftCurosr += 1
        }
        
        if leftCurosr < rightCurosr {
            array.swapAt(leftCurosr, rightCurosr)
        }
    }
    array.swapAt(left, leftCurosr)
    
    quickSort(array: &array, left: left, right: leftCurosr - 1)
    quickSort(array: &array, left: rightCurosr + 1, right: right)
}

func createRandomArray() -> [Int] {
    var array:[Int] = []
    for _ in 0...Int.random(in: 10...20) {
        array.append(Int.random(in: 1...200))
    }
    return array
}
var ary = createRandomArray()
//var  ary = [85, 181, 128, 38, 13, 2, 75, 124, 196, 122, 44, 45, 91, 147, 181, 189]
print(ary)
quickSort(array: &ary, left: 0, right: ary.count-1)
print(ary)
