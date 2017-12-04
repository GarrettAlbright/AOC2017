import Foundation

// http://adventofcode.com/2017/day/2

let input: String
do {
    let path = URL(fileURLWithPath: #file + "/../../../input.txt").standardizedFileURL.path
    input = try String(contentsOfFile: path).trimmingCharacters(in: ["\n", "\r"])
//    print("Input: \(input)")
}
catch {
    print("Couldn't open input file.")
    exit(1)
}

var sum: Int = 0
var part2Sum: Int = 0

for row in input.split(separator: "\n") {
    let rowInt: [Int] = row.components(separatedBy: ["\t"]).map({number in Int(number)!})
    let colCount = rowInt.count
    sum += rowInt.max()! - rowInt.min()!


    perRow: for (idx, val) in rowInt.enumerated() {
        for nextIdx in idx + 1 ..< colCount {
            let nextInt = rowInt[nextIdx]
            if val % nextInt == 0 {
                part2Sum += val / nextInt
                break perRow
            }
            else if nextInt % val == 0 {
                part2Sum += nextInt / val
                break perRow
            }
        }
    }

}

print("Sum is \(sum)")
print("Sum for part 2 is \(part2Sum)")
