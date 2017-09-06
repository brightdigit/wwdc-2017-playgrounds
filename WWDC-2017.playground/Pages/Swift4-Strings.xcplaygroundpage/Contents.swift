//: [Previous](@previous)

//An Example of how to treat a String as an array of characters

import Cocoa

var str = "🎉Welcome to Lansing Cocoaheads, at the 🍎 Store!!🍾"

// as a for loop
for character in str {
  print(character)
}

// subscripts

let indexBeforePopper = str.index(before: str.endIndex)
let indexAppleStoreEnd = str.index(str.endIndex, offsetBy: -4)
let indexAppleStoreStart = str.index(indexAppleStoreEnd, offsetBy: -6)
let popper = str[indexBeforePopper]
let appleStore = str[indexAppleStoreStart...indexAppleStoreEnd]
let strWithLessFanFare = str.dropLast(2)
let strWithLessEmoji = str.filter{ $0.unicodeScalars.contains(where: { $0.isASCII })}
let reverseIt = String(str.reversed())

let splitStrings = str.components(separatedBy: ",")
zip(splitStrings.first!, splitStrings.last!).reduce("") { (current : String, characters : (Character, Character)) -> String in
  return current.appending(String(current.count % 2 == 1 ? characters.1 : characters.0))
}

//: [Next](@next)
