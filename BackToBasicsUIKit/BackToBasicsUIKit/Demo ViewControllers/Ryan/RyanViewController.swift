/*
 - UICollectionView:
    - How to conform to the delegate and dataSource protocols
 - UIAlertController:
    - How to customize them
    - How to present alerts
    - How to interact with it
 */

import UIKit

class RyanViewController: UIViewController {
    var images: [Image]? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "RyanCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        let networking = JSONPlaceholderNetworking()
        networking.getImages(10) { self.images = $0 }
    }
}

extension RyanViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RyanCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RyanCollectionViewCell
        guard let images = images else {
            return RyanCollectionViewCell()
        }
        cell.injectImageUrl(images[indexPath.row].url)
        return cell
    }
}

extension RyanViewController: UICollectionViewDelegate {
    
}
