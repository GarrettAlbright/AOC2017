import Foundation

let inputSet: [Int] = [1, 12, 23, 1024, 265149]

for input in inputSet {

    // Determine the "ring" (minimum steps) away from position 1.
    // Position 1 is ring 0
    // >1^2 to 3^2 is ring 1
    // >3^2 to 5^2 is ring 2
    // >5^2 to 7^2 is ring 3
    // Etc
    // So determine ring position by:
    // - Get ciel(sqrt(input))
    // - Subtract 1 if odd
    // - Divide by 2
    // Tests
    // ceil(sqrt(20)) = 5
    // 5 - 1 = 4
    // 4 / 2 = 2
    //
    // ceil(sqrt(44)) = 7, 7 - 1 = 6, 6 / 2 = 3
    // ceil(sqrt(25)) = 5, 5 - 1 = 4, 4 / 2 = 2
    // ceil(sqrt(49)) = 7, 7 - 1 = 6, 6 / 2 = 3
    // ceil(sqrt(50)) = 8,            8 / 2 = 4

    var ceilSqrt = Int(ceil(sqrt(Double(input))))
    if ceilSqrt % 2 > 0 {
        ceilSqrt -= 1
    }

    let ring = Int(ceilSqrt / 2)

    // Determine values of cardinal positions in the ring. Start with the max value,
    // for the ring (SE position) by ((ring * 2) + 1)^2. Determine S, W, N, E values
    // by calculating SE - ring, SE - (ring * 3), SE - (ring * 5), SE - (ring * 7).

    let se = Int(pow(Double((ring * 2) + 1), 2))
//    let se: Int = round(pow((Decimal((ring * 2) + 1)), 2))
    let ordinals: [Int] = [se - ring, se - (ring * 3), se - (ring * 5), se - (ring * 7)]

    // Find distance to nearest ordinal

    var nearestDistance: Int = Int.max
    for ordinal in ordinals {
        nearestDistance = min(nearestDistance, abs(ordinal - input))
    }

    // So distance to Pos 1 = distance to nearest ordinal plus ring level.

    let distance = nearestDistance + ring

    print("Distance for \(input) is \(distance)")
}

// For part 2, I give up on trying to solve it without actually creating a
// matrix. I'm sure it's possible, but I can't figure it out, and none of the
// solutions I'm seeing online are doing it without matrices either.

let input = 265149
//let input = 1000
let dim = 20

var matrix: [[Int?]] = Array(repeatElement(Array(repeatElement(nil, count: dim)), count: dim))

enum Direction {
    case nw, n, ne, w, e, sw, s, se
}

let centerPos = Int(floor(Double(dim / 2)))

var curPos: (x: Int, y: Int) = (centerPos, centerPos)
matrix[curPos.x][curPos.y] = 1
var spiralDirs: [Direction] = [.e, .n, .w, .s]
let surrounding: [Direction: (x: Int, y: Int)] = [.nw: (-1, -1), .n: (-1, 0), .ne: (-1, 1), .w: (0, -1), .e: (0, 1), .sw: (1, -1), .s: (1, 0), .se: (1, 1)]

var curDir: Int = 0
//var curVal: Int = 1
var steps: Float = 1.0
var curSum = 0

repeatLoop: repeat {
    for _ in 1 ... Int(floor(steps)) {
        curSum = 0
        let curSpiralDir = spiralDirs[curDir]
        let posNextOffset = surrounding[curSpiralDir]!
        curPos = (curPos.x + posNextOffset.x, curPos.y + posNextOffset.y)
        for (_, surroundingOffset) in surrounding {
            let x = curPos.x + surroundingOffset.x
            let y = curPos.y + surroundingOffset.y
            if matrix[x][y] != nil {
                curSum += matrix[x][y]!
            }
        }
        matrix[curPos.x][curPos.y] = curSum
        if curSum > input {
            break repeatLoop
        }
    }
    curDir += 1
    if (curDir == 4) {
        curDir = 0
    }
    steps += 0.5
} while (curSum < input)

for x: Int in 0 ..< dim {
    let row: [Int?] = matrix[x]
    let rowString: [String] = row.map({ num in num == nil ? "nil" : String(num!) })
    print(rowString.joined(separator: "\t"))
}
print("Solution for part 2: \(curSum)")

//for x in 247 ..< 252 {
//    print("\(matrix[x][248])\t\(matrix[x][249])\t\(matrix[x][250])\t\(matrix[x][251])\t\(matrix[x][252])")
//}

