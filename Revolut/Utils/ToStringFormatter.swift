import Foundation

class ToStringFormatter {

    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.roundingMode = .floor
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.minimumIntegerDigits = 1

        return formatter
    }()

    static func displayText(_ value: Double) -> String? {
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", value)
        }
        return formatter.string(from: NSNumber(value: value))
    }
}
