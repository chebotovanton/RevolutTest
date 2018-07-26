import UIKit

class RatesVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet private weak var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        collectionView?.setCollectionViewLayout(layout, animated: false)
        collectionView?.alwaysBounceVertical = true

    }

    //MARK: - UICollectionViewDataSource, UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }

}

