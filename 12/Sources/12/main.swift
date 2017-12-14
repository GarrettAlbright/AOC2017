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

let inputLines = input.split(separator: "\n")
var mappings: [[Int]] = []
var groups: Set<Set<Int>> = []
var splitPattern = try! NSRegularExpression(pattern: "^(\\d+) <-> ([\\d ,]+)$", options: [])
for (idx, line) in input.components(separatedBy: "\n").enumerated() {
    let parts = splitPattern.matches(in: String(line), options: [], range: NSRange(location: 0, length: line.count))
//    let idxRange = Range(parts[0].range(at: 1), in: line)!
    let numsRange = Range(parts[0].range(at: 2), in: line)!
    let nums = String(line[numsRange])
    let addresses = nums.replacingOccurrences(of: " ", with: "").components(separatedBy: ",").map({num in Int(num)!})
    mappings.append(addresses)

}


func findZero(from: [Int], inMappings: [Int]) -> Bool {
    if inMappings.index(of: 0) != nil {
        return true
    }
    else {
        for map in inMappings {
//            var moreFrom = from
//            moreFrom.append(map)
            if from.index(of: map) == nil && findZero(from: from + [map], inMappings: mappings[map]) {
                return true
            }
        }
    }
    return false
}


var reachesZero: [Bool] = []
for x in 0 ..< mappings.count {
    reachesZero.append(findZero(from: [x], inMappings: mappings[x]))
}

let mapToZeroCount = reachesZero.filter({ val in val != false }).count
print("\(mapToZeroCount) ports reach zero")
let groupsCount = groups.count
print("Groups: \(groupsCount)")
