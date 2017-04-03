# TDTSwiftyString

[![CI Status](http://img.shields.io/travis/Todate/TDTSwiftyString.svg?style=flat)](https://travis-ci.org/Todate/TDTSwiftyString)
[![Version](https://img.shields.io/cocoapods/v/TDTSwiftyString.svg?style=flat)](http://cocoapods.org/pods/TDTSwiftyString)
[![License](https://img.shields.io/cocoapods/l/TDTSwiftyString.svg?style=flat)](http://cocoapods.org/pods/TDTSwiftyString)
[![Platform](https://img.shields.io/cocoapods/p/TDTSwiftyString.svg?style=flat)](http://cocoapods.org/pods/TDTSwiftyString)
[![Swift-3.0](http://img.shields.io/badge/Swift-3.0-brightgreen.svg)]()

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

TDTSwiftyString is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "TDTSwiftyString"
```

## Usage

```swift
import TDTSwiftyString
```

## Methods

**length**
```swift
"".length // 0
"0123456789".length // 10
```

**indexOf(target)**
```swift
"0123456789".indexOf("nothing") // -1
"0123456789".indexOf("01") // 0
"0123456789".indexOf("3456") // 3
```

**indexOf(target, startIndex)**
```swift
"constant".indexOf("n", startIndex: 3) // 6
```

**lastIndexOf(target)**
```swift
"changing".lastIndexOf("g") // 7
"meeting".lastIndexOf("e") // 2
```

**substring(from)**
```swift
"0123456789".substring(from: 0) // "0123456789"
"0123456789".substring(from: 3) // "3456789"
"0123456789".substring(from: 9) // "9"
"0123456789".substring(from: -1) // "9"
"0123456789".substring(from: -3) // "789"
```

**substring(to)**
```swift
"0123456789".substring(to: 0) // "0"
"0123456789".substring(to: 3) // "0123"
"0123456789".substring(to: 9) // "0123456789"
"0123456789".substring(to: -1) // "0123456789"
"0123456789".substring(to: -3) // "01234567"
```

**substring(from, to)**
```swift
"0123456789".substring(from: 1, to: 1) // "1"
"0123456789".substring(from: 1, to: 5) // "12345"
```

**substring(from, length)**
```swift
"0123456789".substring(from: 1, length: 0) // ""
"0123456789".substring(from: 1, length: 1) // "1"
"0123456789".substring(from: 1, length: 7) // "1234567"
```

**subscript**
```swift
// index
"0123456789"[0] // "0"
"0123456789"[5] // "5"
"0123456789"[9] // "9"
"0123456789"[-1] // "9"
"0123456789"[-2] // "8"
"0123456789"[-9] // "1"
"0123456789"[-10] // "0"

// range
"0123456789"[0..<0] // ""
"0123456789"[5..<6] // "5"
"0123456789"[0..<1] // "0"
"0123456789"[8..<9] // "8"
"0123456789"[1..<5] // "1234"
"0123456789"[0..<9] // "012345678"

// closed range
"0123456789"[0...0] // "0"
"0123456789"[5...6] // "56"
"0123456789"[0...1] // "01"
"0123456789"[8...9] // "89"
"0123456789"[1...5] // "12345"
"0123456789"[0...9] // "0123456789"
```

**=~ / !~**
```swift
let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"

"email@test.com" =~ emailRegex // true
"email-test.com" !~ emailRegex // true
```

**isMatch(pattern, options)**
```swift
let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"

"email@test.com".isMatch(emailRegex, options: .caseInsensitive) // true
"email-test.com".isMatch(emailRegex, options: .caseInsensitive) // false
```

**getMatches(pattern, options)**
```swift
let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
let testText = "email@test.com, other@test.com, another@test.com"

let matches = testText.getMatches(emailRegex, options: .caseInsensitive)

for (idx, match) in matches.enumerated() {
    let range = match.range

    if range.location != NSNotFound {
        let matchString = testText.substring(from: range.location, length: range.length)

        if !matchString.isEmpty {
            print(matchString)
        }
    }
}
```

**nsRange(target)**
```Swift
var testText = "0123456789"
var target = "78"

var range = testText.nsRange(of: target)
print(range.location) // 7
print(range.length) // 2
```

## License

TDTSwiftyString is available under the MIT license. See the LICENSE file for more info.
