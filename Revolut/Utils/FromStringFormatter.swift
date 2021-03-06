import Foundation

class FromStringFormatter {

    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        return formatter
    }()

    static func amountFrom(_ string: String?) -> Double? {
        if let unwrappedString = string, unwrappedString.count > 0 {
            return formatter.number(from: unwrappedString)?.doubleValue
        } else {
            return 0
        }
    }
}
