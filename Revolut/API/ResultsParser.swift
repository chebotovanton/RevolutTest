import Foundation

class ResultsParser: NSObject {
    static func parseResults(_ dict: [String: Any]) -> [Rate]? {
        guard let rawRates = dict["rates"] as? [String: Double] else { return nil }
        return rawRates.map { (key: String, value: Double) -> Rate in
            return Rate(code: key, value: value)
        }
    }
}
