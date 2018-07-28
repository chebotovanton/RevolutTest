import UIKit

class RatesVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, RatesLoaderDelegate, RateCellDelegate {

    @IBOutlet private weak var collectionView: UICollectionView?

    private let ratesLoader = RatesLoader()

    private var rates: [Rate] = []
    private var currentValue: Double = 1
    private var currentRate = Rate(code: "EUR", value: 1)

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.register(UINib(nibName: "RateCell", bundle: nil), forCellWithReuseIdentifier: RateCell.kCellIdentifier)

        let layout = UICollectionViewFlowLayout()
        collectionView?.setCollectionViewLayout(layout, animated: false)
        collectionView?.alwaysBounceVertical = true

        ratesLoader.delegate = self
        ratesLoader.loadRates(baseCode: "EUR")
    }

    private func updateVisibleCells() {
        let visiblePaths = collectionView?.indexPathsForVisibleItems
        let pathsToReload = visiblePaths?.filter({ (indexPath) -> Bool in
            if let rateCell = collectionView?.cellForItem(at: indexPath) as? RateCell, rateCell.rate?.code == self.currentRate.code {
                return false
            }
            return true
        })
        collectionView?.reloadItems(at: pathsToReload!)
    }

    //MARK: - UICollectionViewDataSource, UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rates.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let sectionInset = (flowLayout?.sectionInset.right ?? 0) + (flowLayout?.sectionInset.left ?? 0)
        let contentInset = collectionView.contentInset.left + collectionView.contentInset.right
        let width = collectionView.frame.width - sectionInset - contentInset

        return CGSize(width: width, height: 80)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RateCell.kCellIdentifier, for: indexPath) as! RateCell

        let rate = rates[indexPath.item]
        cell.setup(rate: rate, amount: currentValue, currentRate: currentRate)
        cell.delegate = self

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? RateCell, let selectedRate = cell.rate else { return }

        //tests?
        if let index = rates.index(where: { selectedRate.code == $0.code }) {
            rates.remove(at: index)
            rates.insert(selectedRate, at: 0)

            let newIndexPath = IndexPath(item: 0, section: indexPath.section)
            collectionView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: true)
            collectionView.performBatchUpdates({
                collectionView.moveItem(at: indexPath, to: newIndexPath)
            }) { (finished) in
                cell.becomeActive()
                self.currentRate = selectedRate
            }
        }
    }

    //MARK: - RatesLoaderDelegate

    func didReceiveRates(_ rates: [Rate]) {
        if self.rates.count == 0 {
            self.rates = rates
            collectionView?.reloadData()
        } else {
            self.rates = RatesSorter.reorderRates(newRates: rates, oldRates: self.rates)
            updateVisibleCells()
        }
    }

    //MARK: - RateCellDelegate

    func amountChanged(_ newAmount: Double, rate: Rate) {
        currentRate = rate
        currentValue = newAmount

        updateVisibleCells()
    }
}
