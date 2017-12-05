import Foundation

// http://adventofcode.com/2017/day/5

let input: String
let inputInstructions: [Int]
do {
    let path = URL(fileURLWithPath: #file + "/../../../input.txt").standardizedFileURL.path
    input = try String(contentsOfFile: path)
    inputInstructions = input.split(separator: "\n").map({ line in Int(line)! })
}
catch {
    print("Couldn't open input file.")
    exit(1)
}

// Part 1
var instrPos = 0
var stepCount = 0
var instructions = inputInstructions
let instrCount = instructions.count

repeat {
    let offset = instructions[instrPos]
    instructions[instrPos] += 1
    instrPos += offset
    stepCount += 1
} while instrPos >= 0 && instrPos < instrCount

print("Step count for part 1: \(stepCount)")

// Part 2
var stepCount2 = 0
instrPos = 0
instructions = inputInstructions
repeat {
    let offset = instructions[instrPos]
    // Unclear by "offset was 3 or more" - would "-4" be an offset of 3 or more?
    // Let's assume that and try it.
//    instructions[instrPos] += abs(offset) >= 3 ? -1 : 1
    // Okay, guess not?
    instructions[instrPos] += offset >= 3 ? -1 : 1
    instrPos += offset
    stepCount2 += 1
} while instrPos >= 0 && instrPos < instrCount

print("Step count for part 2: \(stepCount2)")
