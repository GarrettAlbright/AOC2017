import Foundation

let input: String
do {
    let path = URL(fileURLWithPath: #file + "/../../../input.txt").standardizedFileURL.path
    // Cut off final \n
    input = try String(String(contentsOfFile: path).dropLast(1))
//    input = "ne,ne,s,s"
//    input = "se,sw,se,sw,sw"
//    input = "ne,ne,ne"
//    input = "ne,ne,sw,sw"
}
catch {
    print("Couldn't open input file.")
    exit(1)
}

var x: Int = 0
var y: Int = 0
var z: Int = 0
var furthest: Int = 0
// https://www.redblobgames.com/grids/hexagons/

for move in input.split(separator: ",") {
    switch move {
    case "n":
        y += 1
        z -= 1
        break
    case "ne":
        x += 1
        z -= 1
        break
    case "se":
        x += 1
        y -= 1
        break
    case "s":
        y -= 1
        z += 1
        break
    case "sw":
        x -= 1
        z += 1
        break
    case "nw":
        x -= 1
        y += 1
        break
    default:
        print("oops")
        exit(1)
        break
    }
furthest = max(abs(x), abs(y), abs(z), furthest)

}
print("x: \(x), y: \(y), z: \(z)")
let distance = max(abs(x), abs(y), abs(z))
print("Child is \(distance) steps away")
print("Furthest distance was \(furthest) steps away")

