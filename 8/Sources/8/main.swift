import Foundation

let input: String
do {
    let path = URL(fileURLWithPath: #file + "/../../../input.txt").standardizedFileURL.path
    // Cut off final \n
    input = try String(String(contentsOfFile: path).dropLast(1))
}
catch {
    print("Couldn't open input file.")
    exit(1)
}

var registers: [String: Int] = [:]
var maxSoFar = 0

let pattern = try NSRegularExpression(pattern: "(\\w+) (inc|dec) ([\\d\\-]+) if (\\w+) (>=|<=|!=|==|>|<) ([\\d\\-]+)", options: [])

for line in input.components(separatedBy: "\n") {
    let matches = pattern.matches(in: line, options: [], range: NSRange(location: 0, length: line.count))
    // Do the condition part first
    let conditionRegisterRange = Range(matches[0].range(at: 4), in: line)!
    let conditionRegister = String(line[conditionRegisterRange])
    let conditionComparatorRange = Range(matches[0].range(at: 5), in: line)!
    let conditionComparator = String(line[conditionComparatorRange])
    let conditionValueRange = Range(matches[0].range(at: 6), in: line)!
    let conditionValue = Int(String(line[conditionValueRange]))!

    // FIrst set the compare register if not set
    if registers[conditionRegister] == nil {
        registers[conditionRegister] = 0
    }

    switch conditionComparator {
    case ">=":
        if !(registers[conditionRegister]! >= conditionValue) {
            continue
        }
        break
    case "<=":
        if !(registers[conditionRegister]! <= conditionValue) {
            continue
        }
        break
    case "!=":
        if !(registers[conditionRegister]! != conditionValue) {
            continue
        }
        break
    case "==":
        if !(registers[conditionRegister]! == conditionValue) {
            continue
        }
        break
    case ">":
        if !(registers[conditionRegister]! > conditionValue) {
            continue
        }
        break
    case "<":
        if !(registers[conditionRegister]! < conditionValue) {
            continue
        }
        break
    default:
        print("Unexpected comparator \(conditionComparator).")
        exit(1)
    }

    // Okay, if still here, the condition part succeeded.
    let changeRegisterRange = Range(matches[0].range(at: 1), in: line)!
    let changeRegister = String(line[changeRegisterRange])
    let changeDirRange = Range(matches[0].range(at: 2), in: line)!
    let changeDir = String(line[changeDirRange])
    let changeValRange = Range(matches[0].range(at: 3), in: line)!
    let changeVal = Int(String(line[changeValRange]))!

    // Again, set the register if not already there
    if registers[changeRegister] == nil {
        registers[changeRegister] = 0
    }

    if changeDir == "inc" {
        registers[changeRegister]! += changeVal
    }
    else {
        registers[changeRegister]! -= changeVal
    }
    maxSoFar = max(maxSoFar, registers.values.max()!)
}

let max = registers.values.max()!

print("Max value is \(max)")
print("All time max (part 2) is \(maxSoFar)")
