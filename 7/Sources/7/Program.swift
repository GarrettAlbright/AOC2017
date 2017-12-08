import Foundation

class Program {
    let name: String
    var children: [Program] = []
    var weight: Int?
    var knownParent: String?

    init(name: String, weight: Int?, parent: String?) {
        self.name = name
        self.knownParent = parent
        self.weight = weight
    }

    func addChild(_ program: Program, toParent: String) -> Bool {
        if name == toParent {
            children.append(program)
            return true
        }

        for child in children {
            if child.addChild(program, toParent: toParent) {
                return true
            }
        }
        return false
    }

    func calculateWeight() -> Int {
        var total = 0
        var childWeightCounts: [Int: [Int]] = [:]
        for (idx, child) in children.enumerated() {
            let childWeight = child.calculateWeight()
            if childWeightCounts[childWeight] == nil {
                childWeightCounts[childWeight] = [idx]
            }
            else {
                childWeightCounts[childWeight]!.append(idx)
            }
            total += childWeight
        }
        if childWeightCounts.count > 1 {
            // We found it!
            // Now what was the weight of the odd one out?
            // This way of finding it sucks, but I've spent way too much time
            // on this day's puzzle.
            let first = childWeightCounts.popFirst()!
            let last = childWeightCounts.popFirst()!
            let oddIdx = first.value.count == 1 ? first.value[0] : last.value[0]
            let oddProgram = children.remove(at: oddIdx)
            let aNormalOne = children.popLast()!
            let diff = oddProgram.calculateWeight() - aNormalOne.calculateWeight()
            let neededWeight = oddProgram.weight! - diff
            print("\(oddProgram.name) needs to weigh \(neededWeight)")
            exit(0)
        }
        return total + weight!
    }
}

