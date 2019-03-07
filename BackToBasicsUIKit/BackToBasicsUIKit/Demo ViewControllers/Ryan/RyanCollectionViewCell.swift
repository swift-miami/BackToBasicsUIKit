import UIKit

class RyanCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageCell: UIImageView!
    var image: Image?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public func injectImageUrl(_ url: String) {
        imageCell.downloaded(from: url)
    }
}
