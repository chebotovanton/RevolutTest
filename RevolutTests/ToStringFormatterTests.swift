import XCTest
@testable import Revolut

class ToStringFormatterTests: XCTestCase {

    private let decimalSeparator = NumberFormatter().decimalSeparator!

    func testNoDecimalPart() {
        XCTAssertEqual(ToStringFormatter.displayText(1), "1")
    }

    func testFirstDecimalDigitZero() {
        let result = "1" + decimalSeparator + "01"
        XCTAssertEqual(ToStringFormatter.displayText(1.01), result)
    }

    func testSecondDecimalDigitZero() {
        let result = "1" + decimalSeparator + "10"
        XCTAssertEqual(ToStringFormatter.displayText(1.1), result)
    }

    func testZero() {
        XCTAssertEqual(ToStringFormatter.displayText(0), "0")
    }

    func testRounding() {
        let result = "1" + decimalSeparator + "11"
        XCTAssertEqual(ToStringFormatter.displayText(1.119), result)
    }

    func testComplicatedRounding() {
        let result = "9" + decimalSeparator + "99"
        XCTAssertEqual(ToStringFormatter.displayText(9.9999), result)
    }

    func testHugeNumberFormatting() {
        let result = "12345" + decimalSeparator + "67"
        XCTAssertEqual(ToStringFormatter.displayText(12345.67), result)
    }

}
