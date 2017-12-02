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

for row in input.split(separator: "\n") {
    var rowMin: Int = Int.max
    var rowMax: Int = Int.min
    for column in row.components(separatedBy: ["\t"]) {
        let colVal = Int(column)!
        if colVal < rowMin {
            rowMin = colVal
        }
        else if colVal > rowMax {
            rowMax = colVal
        }
    }
    sum += (rowMax - rowMin)
}

print("Sum is \(sum)")
