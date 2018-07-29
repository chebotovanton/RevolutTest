import XCTest
@testable import Revolut

class RatesConverterTests: XCTestCase {

    func testRealValues() {
        let fromRate = Rate(code: "from", value: 4)
        let toRate = Rate(code: "to", value: 2)

        XCTAssertEqual(RatesConverter.convert(amount: 10, fromRate: fromRate, toRate: toRate), 5)
    }

    func testZeroValue() {
        let fromRate = Rate(code: "from", value: 0)
        let toRate = Rate(code: "to", value: 2)

        XCTAssertEqual(RatesConverter.convert(amount: 10, fromRate: fromRate, toRate: toRate), 0)
    }

}
