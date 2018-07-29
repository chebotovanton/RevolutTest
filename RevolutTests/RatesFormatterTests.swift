import XCTest
@testable import Revolut

class ToStringFormatterTests: XCTestCase {

    func testNoDecimalPart() {
        XCTAssertEqual(ToStringFormatter.displayText(1), "1")
    }

    func testFirstDecimalDigitZero() {
        XCTAssertEqual(ToStringFormatter.displayText(1.01), "1.01")
    }

    func testSecondDecimalDigitZero() {
        XCTAssertEqual(ToStringFormatter.displayText(1.1), "1.10")
    }

    func testZero() {
        XCTAssertEqual(ToStringFormatter.displayText(0), "0")
    }

    func testRounding() {
        XCTAssertEqual(ToStringFormatter.displayText(1.119), "1.11")
    }

    func testComplicatedRounding() {
        XCTAssertEqual(ToStringFormatter.displayText(9.9999), "9.99")
    }

}
