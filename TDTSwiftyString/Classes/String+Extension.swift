import UIKit

infix operator =~
infix operator !~

public func =~(lhs: String, rhs: String) -> Bool {
    guard let regex = try? NSRegularExpression(pattern: rhs,
                                               options: NSRegularExpression.Options()) else {
                                                return false
    }

    return regex.numberOfMatches(in: lhs,
                                 options: NSRegularExpression.MatchingOptions(),
                                 range: NSRange(location: 0, length: lhs.characters.count)) > 0
}

public func !~(lhs: String, rhs: String) -> Bool {
    return !(lhs =~ rhs)
}

extension String {

    // MARK: - length

    public var length: Int {
        return self.characters.count
    }

    // MARK: - substring

    public subscript (i: Int) -> String {
        let start = i >= 0 ? i : self.length + i
        let end = start + 1

        return self[CountableRange(start ..< end)]
    }

    public func substring(from: Int) -> String {
        let start = from >= 0 ? from : self.length + from
        let end = self.length

        return self[CountableRange(start ..< end)]
    }

    public func substring(to: Int) -> String {
        let start = 0
        let end = to >= 0 ? to + 1 : self.length + to + 1

        return self[CountableRange(start ..< end)]
    }

    public func substring(from: Int, to: Int) -> String {
        let start = from >= 0 ? from : self.length + from
        let end = to >= 0 ? to + 1 : self.length + to + 1

        return self[CountableRange(start ..< end)]
    }

    public func substring(from: Int, length: Int) -> String {
        let start = self.index(self.startIndex, offsetBy: from)
        let end = self.index(self.startIndex, offsetBy: from + length)

        return self[Range(start ..< end)]
    }

    public subscript (r: CountableRange<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))

        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)

        return self[Range(start ..< end)]
    }

    public subscript (r: CountableClosedRange<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))

        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound + 1)

        return self[Range(start ..< end)]
    }

    // MARK: - indexOf

    public func indexOf(_ target: String) -> Int {
        if let range = self.range(of: target) {
            return self.distance(from: self.startIndex, to: range.lowerBound)
        } else {
            return -1
        }
    }

    public func indexOf(_ target: String, startIndex: Int) -> Int {
        let startRange = self.index(self.startIndex, offsetBy: startIndex)

        let range = self.range(of: target,
                               options: .literal,
                               range: Range(startRange ..< self.endIndex),
                               locale: Locale.current)

        if let range = range {
            return self.distance(from: self.startIndex, to: range.lowerBound)
        } else {
            return -1
        }
    }

    public func lastIndexOf(_ target: String) -> Int {
        var index = -1
        var stepIndex = self.indexOf(target)

        while stepIndex > -1 {
            index = stepIndex
            if stepIndex + target.length < self.length {
                stepIndex = indexOf(target, startIndex: stepIndex + target.length)
            } else {
                stepIndex = -1
            }
        }

        return index
    }

    // MARK: - RegularExpression

    public func isMatch(_ regex: String, options: NSRegularExpression.Options) -> Bool {
        guard let exp = try? NSRegularExpression(pattern: regex, options: options) else {
            return false
        }

        let matchCount = exp.numberOfMatches(in: self,
                                             options: [],
                                             range: NSMakeRange(0, self.length))

        return matchCount > 0
    }

    public func getMatches(_ regex: String, options: NSRegularExpression.Options) -> [NSTextCheckingResult] {
        guard let exp = try? NSRegularExpression(pattern: regex, options: options) else {
            return []
        }

        let matches = exp.matches(in: self,
                                  options: [],
                                  range: NSMakeRange(0, self.length))

        return matches as [NSTextCheckingResult]
    }

    // MARK: - range

    public func nsRange(of target: String) -> NSRange {
        let range = (self as NSString).range(of: target)
        return range
    }

}
