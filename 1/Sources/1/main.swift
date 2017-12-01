import Foundation

// http://adventofcode.com/2017/day/1

let input: String
do {
    let path = URL(fileURLWithPath: #file + "/../../../input.txt").standardizedFileURL.path
    input = try String(contentsOfFile: path).trimmingCharacters(in: ["\n", "\r"])
    print("Input: \(input)")
}
catch {
    print("Couldn't open input file.")
    exit(1)
}

let inputLength = input.count

// Part 1

// Extract all digits that do not have the same digit next using lookahead
let pattern = try! NSRegularExpression(pattern: "(\\d)(?!\\1)", options: [])
let range = NSRange(location: 0, length: inputLength)

var stripped = pattern.stringByReplacingMatches(in: input, options: [.withTransparentBounds], range: range, withTemplate: "") as String

// Special case for first/last chars
if input.first! == input.last! {
    let lastString = String(input.last!)
    stripped.append(lastString)
}

print("Stripped: \(stripped)")

var total: Int = 0

for char in stripped {
    let charStr = String(char)
    let charInt = Int(charStr)!
    total += charInt
}

print("Total for part 1: \(total)")

// Part 2

let halfway = inputLength / 2

var halfwayRoundTotal: Int = 0

// Only do half the string since the second half will have the same sum
for x in 0 ..< halfway {
    let halfwayPos = x + halfway
    let firstIndex = input.index(input.startIndex, offsetBy: x)
    let secondIndex = input.index(input.startIndex, offsetBy: halfwayPos)
    if input[firstIndex] == input[secondIndex] {
        halfwayRoundTotal += Int(String(input[firstIndex]))!
    }

}

halfwayRoundTotal = halfwayRoundTotal * 2
print("Total for part 2: \(halfwayRoundTotal)")
