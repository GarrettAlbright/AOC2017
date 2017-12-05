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
var valid2: Int = 0

for passphrase in input.split(separator: "\n") {
    let words = passphrase.split(separator: " ")
    // Converting array to set will remove duplicate elements
    // https://stackoverflow.com/a/27624476/11023
    if words.count == Set(words).count {
        valid += 1
    }
    // Abuse sets again to find anagrams since Set(["a", "b", "c"]) ==
    // Set(["b", "c", "a"])
    // Look at this mess oh my gosh this is write-only code
    let wordsSet: Set<Set<String>> = Set(words.map({ word in Set(Array(word).map({ char in String(char) })) }))
    if words.count == wordsSet.count {
        valid2 += 1
    }
}

print("Valid passphrases: \(valid)")
print("Valid passphrases part 2: \(valid2)")
