import UIKit
import SDWebImage

protocol RateCellDelegate: class {
    func amountChanged(_ newAmount: Double, rate: Rate)
    func selectRate(rate: Rate, amount: Double)
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

        flagView?.layer.cornerRadius = 20
        flagView?.clipsToBounds = true
    }

    func setup(rate: Rate, amount: Double, currentRate: Rate) {
        self.rate = rate
        codeLabel?.text = rate.code
        descriptionLabel?.text = Locale.current.localizedString(forCurrencyCode: rate.code)

        let amountToPresent = RatesConverter.convert(amount: amount, fromRate: currentRate, toRate: rate)
        amountField?.text = ToStringFormatter.displayText(amountToPresent)

        let urlString = FlagUrlFactory.countryFlagUrl(rate.code)
        flagView?.sd_setImage(with: URL(string: urlString), completed: nil)
    }

    func becomeActive() {
        amountField?.becomeFirstResponder()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        guard let amount = FromStringFormatter.amountFrom(updatedString) else { return false }

        if let rate = rate {
            delegate?.amountChanged(amount, rate: rate)
        }

        return true
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        underline?.backgroundColor = RateCell.selectedColor
        if let text = textField.text, let amount = FromStringFormatter.amountFrom(text), let rate = rate {
            delegate?.selectRate(rate: rate, amount: amount)
        }

        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        underline?.backgroundColor = RateCell.grayColor

        return true
    }

}
