import Foundation

let input = "63,144,180,149,1,255,167,84,125,65,188,0,2,254,229,24"
//let input = "3,4,1,5"
//let input = "1,2,3"
//let input = ""

var list: [Int] = Array(0...255)
//var list: [Int] = Array(0...4)

let listLen = list.count

var curPos: Int = 0
var skipSize: Int = 0

for toTwistStr in input.split(separator: ",") {
    let toTwist = Int(toTwistStr)!
    if curPos + toTwist >= listLen {
        let wrapAround = (curPos + toTwist) % listLen
        var listToReverse = list[curPos..<list.endIndex] + list[0..<wrapAround]
        listToReverse.reverse()
        list[curPos..<list.endIndex] = listToReverse[curPos..<list.endIndex]
        list[0..<wrapAround] = listToReverse[list.endIndex..<listToReverse.endIndex]

    }
    else {
        list[curPos..<curPos+toTwist].reverse()
    }

    curPos = curPos + toTwist + skipSize
    if (curPos >= listLen) {
        curPos = curPos % listLen
    }
    skipSize += 1
}

let firstTwoMultiplied = list[0] * list[1]

print("Checksum is \(firstTwoMultiplied)")

// Part 2

//let inputData = Data(bytes: input.cha

let inputArray = input.unicodeScalars.map({ char in Int(char.value) }) + [17, 31, 73, 47, 23]
//let inputData = Data(bytes: inputArray) + Data(bytes: [17, 31, 73, 47, 23])

curPos = 0
skipSize = 0

let dataLen = inputArray.count
list = Array(0...255)

for _ in 0 ..< 64 {
    for toTwist in inputArray {
        if curPos + toTwist >= dataLen {
            let wrapAround = (curPos + toTwist) % listLen
            var listToReverse = list[curPos..<list.endIndex] + list[0..<wrapAround]
            listToReverse.reverse()
            list[curPos..<list.endIndex] = listToReverse[curPos..<list.endIndex]
            list[0..<wrapAround] = listToReverse[list.endIndex..<listToReverse.endIndex]

        }
        else {
            list[curPos..<curPos+toTwist].reverse()
        }

        curPos = curPos + toTwist + skipSize
        if (curPos >= listLen) {
            curPos = curPos % listLen
        }
        skipSize += 1
    }
}

var denseHash = ""

for set in 0..<16 {
    let start = 16 * set
    var xorTotal = 0
    _ = list[start..<start+16].map({ value in
        xorTotal = xorTotal ^ value
    })
    denseHash.append(String(format: "%02x", xorTotal))
}

print("I think the dense hash is \(denseHash)")
print("This is wrong. Maybe I'll come back to this later. But I feel like I don't have enough information in the puzzle description to find where things are going wrong.")
