import XCTest
@testable import Revolut

class FromStringFormatterTests: XCTestCase {

    func testZero() {
        XCTAssertEqual(FromStringFormatter.amountFrom("0"), 0)
    }

    func testNilString() {
        XCTAssertEqual(FromStringFormatter.amountFrom(nil), 0)
    }

    func testEmptyString() {
        XCTAssertEqual(FromStringFormatter.amountFrom(""), 0)
    }

    func testValidDoubleValue() {
        let separator = NumberFormatter().decimalSeparator!
        let string = "5" + separator + "9999"

        XCTAssertEqual(FromStringFormatter.amountFrom(string), 5.9999)
    }

    func testTwoDots() {
        XCTAssertEqual(FromStringFormatter.amountFrom("0.0.1"), nil)
    }

    func testTwoCommas() {
        XCTAssertEqual(FromStringFormatter.amountFrom("10,10,1"), nil)
    }

    func testTwoDecimalSeparators() {
        // can there be another separator aside from dot and comma?
        let separator = NumberFormatter().decimalSeparator!
        let string = "5" + separator + "9999" + separator + "03"

        XCTAssertEqual(FromStringFormatter.amountFrom(string), nil)
    }

    func testNaN() {
        XCTAssertEqual(FromStringFormatter.amountFrom("5.5abc"), nil)
    }

}
