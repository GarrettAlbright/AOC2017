import Foundation

// http://adventofcode.com/2017/day/4

let input: String
do {
    let path = URL(fileURLWithPath: #file + "/../../../input.txt").standardizedFileURL.path
    input = try String(contentsOfFile: path)
//    print("Input: \(input)")
}
catch {
    print("Couldn't open input file.")
    exit(1)
}

var valid: Int = 0

for passphrase in input.split(separator: "\n") {
    let words = passphrase.split(separator: " ")
    // Converting array to set will remove duplicate elements
    // https://stackoverflow.com/a/27624476/11023
    if words.count == Set(words).count {
        valid += 1
    }
}

print("Valid passphrases: \(valid)")

