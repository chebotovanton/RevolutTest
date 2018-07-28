import UIKit

protocol RateCellDelegate: class {
    func amountChanged(_ newAmount: Double, rate: Rate)
}

class RateCell: UICollectionViewCell, UITextFieldDelegate {

    static let kCellIdentifier = "RateCell"
    private static let selectedColor = UIColor(red: 60.0/255.0, green: 90.0/255.0, blue: 160.0/255.0, alpha: 1)
    private static let grayColor = UIColor(red: 226.0/255.0, green: 226.0/255.0, blue: 226.0/255.0, alpha: 1)

    var rate: Rate?
    weak var delegate: RateCellDelegate?

    @IBOutlet private weak var flagView: UIImageView?
    @IBOutlet private weak var codeLabel: UILabel?
    @IBOutlet private weak var descriptionLabel: UILabel?
    @IBOutlet private weak var amountField: UITextField?
    @IBOutlet private weak var underline: UIView?

    override func awakeFromNib() {
        super.awakeFromNib()

        amountField?.keyboardType = .decimalPad
        underline?.backgroundColor = RateCell.grayColor
    }

    func setup(rate: Rate, amount: Double, currentRate: Rate) {
        self.rate = rate
        codeLabel?.text = rate.code
        descriptionLabel?.text = Locale.current.localizedString(forCurrencyCode: rate.code)
        //warning: move to some converter
        let amountToPresent = RatesConverter.convert(amount: amount, from: currentRate, to: rate)
        amountField?.text = RatesFormatter.displayText(amountToPresent)
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

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        underline?.backgroundColor = RateCell.selectedColor

        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        underline?.backgroundColor = RateCell.grayColor

        return true
    }

}
