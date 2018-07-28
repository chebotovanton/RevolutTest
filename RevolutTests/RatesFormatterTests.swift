import XCTest
@testable import Revolut

class RatesFormatterTests: XCTestCase {

    func testNoDecimalPart() {
        XCTAssertEqual(RatesFormatter.displayText(1), "1")
    }

    func testFirstDecimalDigitZero() {
        XCTAssertEqual(RatesFormatter.displayText(1.01), "1.01")
    }

    func testSecondDecimalDigitZero() {
        XCTAssertEqual(RatesFormatter.displayText(1.1), "1.10")
    }

    func testZero() {
        XCTAssertEqual(RatesFormatter.displayText(0), "0")
    }

    func testRounding() {
        XCTAssertEqual(RatesFormatter.displayText(1.119), "1.11")
    }

    func testComplicatedRounding() {
        XCTAssertEqual(RatesFormatter.displayText(9.9999), "9.99")
    }

}
