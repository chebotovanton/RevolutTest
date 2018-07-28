import XCTest
@testable import Revolut

class RatesSorterTests: XCTestCase {

    func testSameAmount() {
        let oldRates = [Rate(code: "CODE1", value: 1),
                        Rate(code: "CODE2", value: 2),
                        Rate(code: "CODE3", value: 3)]

        let newRates = [Rate(code: "CODE2", value: 5),
                        Rate(code: "CODE3", value: 6),
                        Rate(code: "CODE1", value: 4)]

        let sortedRates = RatesSorter.reorderRates(newRates: newRates, oldRates: oldRates)

        XCTAssertEqual(sortedRates.count, 3)

        XCTAssertEqual(sortedRates[0].code, "CODE1")
        XCTAssertEqual(sortedRates[0].value, 4)

        XCTAssertEqual(sortedRates[1].code, "CODE2")
        XCTAssertEqual(sortedRates[1].value, 5)

        XCTAssertEqual(sortedRates[2].code, "CODE3")
        XCTAssertEqual(sortedRates[2].value, 6)
    }

    func testMoreNewRates() {
        let oldRates = [Rate(code: "CODE2", value: 2),
                        Rate(code: "CODE3", value: 3)]

        let newRates = [Rate(code: "CODE2", value: 5),
                        Rate(code: "CODE3", value: 6),
                        Rate(code: "CODE1", value: 4)]

        let sortedRates = RatesSorter.reorderRates(newRates: newRates, oldRates: oldRates)

        XCTAssertEqual(sortedRates.count, 3)

        XCTAssertEqual(sortedRates[0].code, "CODE2")
        XCTAssertEqual(sortedRates[0].value, 5)

        XCTAssertEqual(sortedRates[1].code, "CODE3")
        XCTAssertEqual(sortedRates[1].value, 6)

        XCTAssertEqual(sortedRates[2].code, "CODE1")
        XCTAssertEqual(sortedRates[2].value, 4)
    }

    func testLessNewRates() {
        let oldRates = [Rate(code: "CODE1", value: 1),
                        Rate(code: "CODE2", value: 2),
                        Rate(code: "CODE3", value: 3)]

        let newRates = [Rate(code: "CODE2", value: 5),
                        Rate(code: "CODE3", value: 6)]

        let sortedRates = RatesSorter.reorderRates(newRates: newRates, oldRates: oldRates)

        XCTAssertEqual(sortedRates.count, 3)

        XCTAssertEqual(sortedRates[0].code, "CODE1")
        XCTAssertEqual(sortedRates[0].value, 1)

        XCTAssertEqual(sortedRates[1].code, "CODE2")
        XCTAssertEqual(sortedRates[1].value, 5)

        XCTAssertEqual(sortedRates[2].code, "CODE3")
        XCTAssertEqual(sortedRates[2].value, 6)
    }

    
}
