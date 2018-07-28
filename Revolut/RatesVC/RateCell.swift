import UIKit

protocol RateCellDelegate: class {
    func amountChanged(_ newAmount: Double, rate: Rate)
}

class RateCell: UICollectionViewCell, UITextFieldDelegate {

    static let kCellIdentifier = "RateCell"

    var rate: Rate?
    weak var delegate: RateCellDelegate?

    @IBOutlet private weak var flagView: UIImageView?
    @IBOutlet private weak var codeLabel: UILabel?
    @IBOutlet private weak var descriptionLabel: UILabel?
    @IBOutlet private weak var amountField: UITextField?

    override func awakeFromNib() {
        super.awakeFromNib()

        amountField?.keyboardType = .decimalPad
    }

    func setup(rate: Rate, amount: Double, currentRate: Rate) {
        self.rate = rate
        codeLabel?.text = rate.code
        descriptionLabel?.text = Locale.current.localizedString(forCurrencyCode: rate.code)
        //warning: move to some converter
        amountField?.text = String(RatesConverter.convert(amount: amount, from: currentRate, to: rate))
    }

    func becomeActive() {
        amountField?.becomeFirstResponder()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        //warning: fix this mess
        var updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? "0"
        if updatedString.count == 0 {
            updatedString = "0"
        }

        //warning: if updated string contains two dots, return false + tests
        guard let newValue = Double(updatedString) else { return false }
        guard let rate = rate else { return true }

        delegate?.amountChanged(newValue, rate: rate)

        return true
    }

}
