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
        let networking = JSONPlaceholderNetworking()
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
    // didSelect is when a user selects a cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        // Going to need the data on the image
        let image = images[indexPath.row]

        // Going to determine if the current item number in the collection is even or odd to show the 2 different types of alert controller
        let style: UIAlertController.Style = (indexPath.row % 2) == 0 ? UIAlertController.Style.actionSheet : UIAlertController.Style.alert

        // Going to initialize the alert controller to display the
        let alert = UIAlertController(title: String(describing: image.albumId), message: image.title, preferredStyle: style)

        // UIAlertAction takes a handler, this would be how you would respond to button presses
        // So if a user presses OK and you need to do an action from there this is where you would do define that logic
        // In this case we'll just print the title of the alert action
        let printTitle: (UIAlertAction) -> () = { print($0.title!) }

        // There are 3 types of UIAlertAction OK, DEFAULT & DESTRUCTIVE
        // Dev must add the action to the alert
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: printTitle))
        alert.addAction(UIAlertAction(title: "DEFAULT", style: .default, handler: printTitle))
        alert.addAction(UIAlertAction(title: "DESTRUCTIVE", style: .destructive, handler: printTitle))

        // Present the alert to be displayed in the current vc
        present(alert, animated: true, completion: nil)
    }
}

extension RyanViewController: UICollectionViewDelegateFlowLayout {
    // Need to reseize? Do it here! (sorta)
    // Might want to read some about UICollectionViewLayout: https://developer.apple.com/documentation/uikit/uicollectionviewlayout#
    // And UICollectionViewFlowLayout: https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout (Preferred method)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 300)
    }
}
