import Foundation

//tests

class ResultsParser: NSObject {
    static func parseResults(_ dict: [String: Any]) -> [Rate]? {
        return dict.compactMap { (key: String, value: Any) -> Rate? in
            guard let floatValue = value as? Float else { return nil }

            return Rate(code: key, value: floatValue)
        }
    }
}
