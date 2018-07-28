import Foundation

class RatesFormatter {

    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.minimumIntegerDigits = 1

        return formatter
    }()

    static func displayText(_ value: Double) -> String? {
        return formatter.string(from: NSNumber(value: value))
    }
}
