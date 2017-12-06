import Foundation

// http://adventofcode.com/2017/day/6

var banks: [Int]
var bankHistory: [[Int]] = []
let bankCount: Int

do {
    let path = URL(fileURLWithPath: #file + "/../../../input.txt").standardizedFileURL.path
    let input = try String(contentsOfFile: path).trimmingCharacters(in: ["\n"])
    banks = input.split(separator: "\t").map({ blocks in Int(blocks)! })
//    banks = [0, 2, 7, 0]
    bankCount = banks.count
    //    print("Input: \(input)")
}
catch {
    print("Couldn't open input file.")
    exit(1)
}

var loopCount = 0;

var previousFindIdx: Int?
repeat {
    bankHistory.append(banks)
    let (maxPos, maxVal) = banks.enumerated().max(by: { a, b in a.element < b.element })!
    let addToAll = Int(floor(Double(maxVal) / Double(bankCount)))
    let toGetMore = maxVal % bankCount
    var fillPos = maxPos
    // Empty the max pos
    banks[maxPos] = addToAll
    for bankLoop in 0 ..< bankCount - 1 {
        fillPos += 1
        if (fillPos == bankCount) {
            fillPos = 0
        }
        banks[fillPos] += (bankLoop < toGetMore ? addToAll + 1 : addToAll)
    }
    loopCount += 1
    let banksString: [String] = banks.map({ val in String(val) })
    print(banksString.joined(separator: "\t"))
    previousFindIdx = bankHistory.enumerated().filter({ $0.element == banks }).first?.offset
// Do filter here since there doesn't seem to be an .index(of:) that works
// with arrays (not hashable?)
} while previousFindIdx == nil

print("Loop count was \(loopCount)")
let cycleCount = loopCount - previousFindIdx!
print("Cycle count since last appearance was \(cycleCount)")
