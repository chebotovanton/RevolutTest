import UIKit

class RatesVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, RatesLoaderDelegate {

    @IBOutlet private weak var collectionView: UICollectionView?

    private let ratesLoader = RatesLoader()

    private var rates: [Rate] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.register(UINib(nibName: "RateCell", bundle: nil), forCellWithReuseIdentifier: RateCell.kCellIdentifier)

        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        collectionView?.setCollectionViewLayout(layout, animated: false)
        collectionView?.alwaysBounceVertical = true

        ratesLoader.delegate = self
        ratesLoader.loadRates(baseCode: "EUR")
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
        cell.setup(rate)

        return cell
    }

    //MARK: - RatesLoaderDelegate

    func didReceiveRates(_ rates: [Rate]) {
        self.rates = rates
        collectionView?.reloadData()
    }

}

