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

var parentKnown: [String: Bool] = [:]
let parentagePattern = try NSRegularExpression(pattern: "(\\w+) \\((\\d+)\\)(?: -> ([\\w, ]+))?", options: [])

for line in input.components(separatedBy: "\n") {
    let matches = parentagePattern.matches(in: line, options: [], range: NSRange(location: 0, length: line.count))
    let nameRange = Range(matches[0].range(at: 1), in: line)!
    let name = String(line[nameRange])
    if parentKnown.index(forKey: name) == nil {
        parentKnown[name] = false
    }

    if let childrenRange = Range(matches[0].range(at: 3), in: line) {
        let childrenString = String(line[childrenRange])
        for child in childrenString.components(separatedBy: ", ") {
            parentKnown[child] = true
        }
    }
}

let unknownParent = parentKnown.filter({ key, value in value == false }).first!
print("Bottom program is \(unknownParent.key)")

// Part 2 strategy:
// - Create object with array of child nodes in linked list type structure
// - Each object has calculateWeight method which calcs weight of self plus
// children; determines if unbalance exists in the process
// - Start with "bottom program"
