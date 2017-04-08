// https://github.com/Quick/Quick

import Quick
import Nimble
import TDTSwiftyString

class TableOfContentsSpec: QuickSpec {

    override func spec() {

        // MARK: - length

        describe("length") {
            context("") {
                it("these will pass") {
                    expect("".length) == 0
                    expect("0123456789".length) == 10
                }
            }
        }

        // MARK: - indexOf

        describe("indexOf") {
            context("only target") {
                it("these will pass") {
                    expect("0123456789".indexOf("nothing")) == -1
                    expect("0123456789".indexOf("01")) == 0
                    expect("0123456789".indexOf("3456")) == 3
                }
            }

            context("with startIndex") {
                it("these will pass") {
                    expect("constant".indexOf("n", startIndex: 3)) == 6
                    expect("constant".indexOf("t", startIndex: 3)) == 4
                    expect("constant".indexOf("z", startIndex: 3)) == -1
                }
            }
        }

        // MARK: - lastIndexOf

        describe("lastIndexOf") {
            context("only target") {
                it("these will pass") {
                    expect("changing".lastIndexOf("c")) == 0
                    expect("changing".lastIndexOf("g")) == 7
                    expect("meeting".lastIndexOf("e")) == 2
                    expect("meeting".lastIndexOf("z")) == -1
                }
            }
        }

        // MARK: - substring

        describe("substring") {
            context("from") {
                it("these will pass") {
                    expect("0123456789".substring(from: 0)) == "0123456789"
                    expect("0123456789".substring(from: 3)) == "3456789"
                    expect("0123456789".substring(from: 9)) == "9"
                    expect("0123456789".substring(from: -1)) == "9"
                    expect("0123456789".substring(from: -3)) == "789"
                }
            }

            context("to") {
                it("these will pass") {
                    expect("0123456789".substring(to: 0)) == "0"
                    expect("0123456789".substring(to: 3)) == "0123"
                    expect("0123456789".substring(to: 9)) == "0123456789"
                    expect("0123456789".substring(to: -1)) == "0123456789"
                    expect("0123456789".substring(to: -3)) == "01234567"
                }
            }

            context("from,to") {
                it("these will pass") {
                    expect("0123456789".substring(from: 1, to: 1)) == "1"
                    expect("0123456789".substring(from: 1, to: 5)) == "12345"
                }
            }

            context("start,length") {
                it("these will pass") {
                    expect("0123456789".substring(from: 1, length: 0)) == ""
                    expect("0123456789".substring(from: 1, length: 1)) == "1"
                    expect("0123456789".substring(from: 1, length: 7)) == "1234567"
                }
            }
        }

        // MARK: - subscript

        describe("subscript") {
            context("index") {
                it("these will pass") {
                    expect("0123456789"[0]) == "0"
                    expect("0123456789"[5]) == "5"
                    expect("0123456789"[9]) == "9"
                    expect("0123456789"[-1]) == "9"
                    expect("0123456789"[-2]) == "8"
                    expect("0123456789"[-9]) == "1"
                    expect("0123456789"[-10]) == "0"
                }
            }

            context("range") {
                it("these will pass") {
                    expect("0123456789"[0..<0]) == ""
                    expect("0123456789"[5..<6]) == "5"
                    expect("0123456789"[0..<1]) == "0"
                    expect("0123456789"[8..<9]) == "8"
                    expect("0123456789"[1..<5]) == "1234"
                    expect("0123456789"[0..<9]) == "012345678"
                }
            }

            context("closed range") {
                it("these will pass") {
                    expect("0123456789"[0...0]) == "0"
                    expect("0123456789"[5...6]) == "56"
                    expect("0123456789"[0...1]) == "01"
                    expect("0123456789"[8...9]) == "89"
                    expect("0123456789"[1...5]) == "12345"
                    expect("0123456789"[0...9]) == "0123456789"
                }
            }
        }

        // MARK: - RegularExpression

        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"

        describe("RegularExpression") {
            context("operator") {
                it("these will pass") {
                    expect(emailRegex =~ "email@test.com") == 0
                    expect(emailRegex =~ "email-test.com").to(beNil())

                    expect("test" =~ "email@test.com") == 6

                    expect("cde" =~ "abcdefghijk") == 2
                    expect("cde" =~ "abcdefabcdef") == 2

                    expect("cde" =~ "abcde") == 2
                    expect("^cde" =~ "abcde").to(beNil())
                    expect("cde$" =~ "abcde") == 2
                    expect("^cde$" =~ "abcde").to(beNil())
                    expect("^abcde$" =~ "abcde") == 0

                    expect("CDE" =~ "abcdefghijk").to(beNil())

                    expect("[0-9]+" =~ "abc0123abc0123") == 3

                    expect("[0-9]{4}" =~ "abc0123abc0123") == 3
                    expect("[0-9]{5}" =~ "abc0123abc0123").to(beNil())

                    expect("\\d{4}" =~ "abc0123abc0123") == 3

                    expect("\\d{4}-\\d{4}" =~ "090-1234-5678") == 4
                }
            }

            context("isMatch") {
                it("these will pass") {
                    expect("email@test.com".isMatch(emailRegex, options: .caseInsensitive)) == true
                    expect("email-test.com".isMatch(emailRegex, options: .caseInsensitive)) == false
                }
            }

            context("getMatches") {
                it("these will pass") {
                    let testText = "email@test.com, other@test.com, another@test.com"
                    let matchStrings = ["email@test.com", "other@test.com", "another@test.com"]

                    let matches = testText.getMatches(emailRegex, options: .caseInsensitive)

                    for (idx, match) in matches.enumerated() {
                        let range = match.range

                        if range.location != NSNotFound {
                            let matchString = testText.substring(from: range.location, length: range.length)
                            
                            if !matchString.isEmpty {
                                expect(matchString == matchStrings[idx]) == true
                            }
                        }
                    }
                }
            }
        }

        // MARK: - range

        describe("range") {
            context("target range") {
                it("these will pass") {

                    var testText = "0123456789"
                    var target = "78"

                    var range = testText.nsRange(of: target)
                    expect(range.location) == 7
                    expect(range.length) == 2

                    testText = "テスト用の文字列です"
                    target = "文字列"

                    range = testText.nsRange(of: target)
                    expect(range.location) == 5
                    expect(range.length) == 3

                    testText = "0123456789"
                    target = "abc"

                    range = testText.nsRange(of: target)

                    expect(range.location == NSNotFound) == true
                }
            }
        }

    }
}
