import UIKit

class RateCell: UICollectionViewCell {

    static let kCellIdentifier = "RateCell"

    @IBOutlet private weak var flagView: UIImageView?
    @IBOutlet private weak var codeLabel: UILabel?
    @IBOutlet private weak var descriptionLabel: UILabel?
    @IBOutlet private weak var amountField: UITextField?

    override func awakeFromNib() {
        super.awakeFromNib()

        amountField?.keyboardType = .decimalPad
    }

}