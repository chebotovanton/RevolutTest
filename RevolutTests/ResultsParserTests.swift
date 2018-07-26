import XCTest
@testable import Revolut

class ResultsParserTests: XCTestCase {

    func testParsing() {
        //what's the order problem?
        let rawRates = ["AUD" : 1.5857,
                     "BGN":1.9606,
                     "BRL":4.4474,
                     "CAD":1.5481,
                     "CHF":1.1662,
                     "CNY":7.9406,
                     "CZK":25.939]
        let dict: [String : Any] = ["base" : "EUR",
                                    "date" : "2018-07-20",
                                    "rates": rawRates]

        let rates = ResultsParser.parseResults(dict)!

        XCTAssertEqual(rates.count, 7)
        let aud = rawRates.first
        XCTAssertEqual(aud?.value, 25.939)
    }

    func testWrongValue() {
        let rawRates: [String : Any] = ["AUD" : 1.5857,
                        "BGN" : "wrongValue"]
        let dict: [String : Any] = ["base" : "EUR",
                                    "date" : "2018-07-20",
                                    "rates": rawRates]

        let rates = ResultsParser.parseResults(dict)

        XCTAssertNil(rates)
    }

    func testWrongResponseStructure() {
        let rawRates: [String : Any] = ["AUD" : 1.5857,
                                        "BGN" : 1.9606]
        let dict: [String : Any] = ["base" : "EUR",
                                    "date" : "2018-07-20",
                                    "wrongKey" : rawRates]

        let rates = ResultsParser.parseResults(dict)

        XCTAssertNil(rates)
    }
        
}
