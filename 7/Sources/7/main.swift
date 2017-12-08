import Foundation

let input: String
do {
    let path = URL(fileURLWithPath: #file + "/../../../input.txt").standardizedFileURL.path
    // Cut off final \n
    input = try String(String(contentsOfFile: path).dropLast(1))
//    input = """
//pbga (66)
//xhth (57)
//ebii (61)
//havc (66)
//ktlj (57)
//fwft (72) -> ktlj, cntj, xhth
//qoyq (66)
//padx (45) -> pbga, havc, qoyq
//tknk (41) -> ugml, padx, fwft
//jptl (61)
//ugml (68) -> gyxo, ebii, jptl
//gyxo (61)
//cntj (57)
//"""
}
catch {
    print("Couldn't open input file.")
    exit(1)
}

var programs: [String: Program] = [:]
let parentagePattern = try NSRegularExpression(pattern: "(\\w+) \\((\\d+)\\)(?: -> ([\\w, ]+))?", options: [])

for line in input.components(separatedBy: "\n") {
    let matches = parentagePattern.matches(in: line, options: [], range: NSRange(location: 0, length: line.count))
    let nameRange = Range(matches[0].range(at: 1), in: line)!
    let name = String(line[nameRange])
    if programs.index(forKey: name) == nil {
        var program = Program(name: name, weight: nil, parent: nil)
        programs[name] = program
    }
//    else {
//        programs[name]!.weight = weight
//    }

    if let childrenRange = Range(matches[0].range(at: 3), in: line) {
        let childrenString = String(line[childrenRange])
        for child in childrenString.components(separatedBy: ", ") {
            var program = Program(name: child, weight: nil, parent: name)
            programs[child] = program
        }
    }
}

let unknownParent = programs.filter({ (arg) -> Bool in let (_, program) = arg; return program.knownParent == nil }).first!.value
print("Bottom program is \(unknownParent.name)")

// Go through again and set weights
for line in input.components(separatedBy: "\n") {
    let matches = parentagePattern.matches(in: line, options: [], range: NSRange(location: 0, length: line.count))
    let nameRange = Range(matches[0].range(at: 1), in: line)!
    let name = String(line[nameRange])
    let weightRange = Range(matches[0].range(at: 2), in: line)!
    let weight = Int(String(line[weightRange]))!
    programs[name]!.weight = weight
}
// Build the tree
programs.removeValue(forKey: unknownParent.name)
repeat {
    for (name, program) in programs {
        if program.knownParent != nil {
            if unknownParent.addChild(program, toParent: program.knownParent!) {
                programs.removeValue(forKey: name)
                print("Found a place for \(name)")
            }
        }
    }
    print("programs.count is \(programs.count)")
} while programs.count > 0

unknownParent.calculateWeight()

