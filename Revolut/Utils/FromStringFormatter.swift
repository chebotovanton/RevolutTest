import UIKit

class FromStringFormatter: NSObject {

    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
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
