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
    @IBOutlet weak var collectionView: UICollectionView!
    var images = [Image]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Need to register the nib that is going to be used
        collectionView.register(UINib(nibName: String(describing: RyanCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: "cell")
        // Set the class as the data source so the collection view knows where to find it's data
        collectionView.dataSource = self
        // Set the class as the collection view delegate so that it can respond to any actions emitted from the collection view
        collectionView.delegate    = self
        
        // Lets get some data!
        let networking             = JSONPlaceholderNetworking()
        networking.getImages(10) { self.images = $0 }
    }
}

extension RyanViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // The collection view will display our images so the number of items is the number of images
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Collection views work similar to table views, it grabs the cell as it passes off screen and then re-uses it
        // To display up next as a user scrolls
        let cell: RyanCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RyanCollectionViewCell
        
        // Takes an image url
        cell.injectImageUrl(images[indexPath.row].url)
        
        // Return the cell with the new content
        return cell
    }
}

extension RyanViewController: UICollectionViewDelegate {
    
}
