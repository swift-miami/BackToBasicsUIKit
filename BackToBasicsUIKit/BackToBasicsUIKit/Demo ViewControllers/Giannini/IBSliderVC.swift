import UIKit

class IBSliderVC: UIViewController {
    @IBOutlet var drakeView: UIImageView!
    @IBOutlet var ibSliderLabel: UILabel!
    @IBAction func didMoveSlider(_ sender: UISlider) {
        ibSliderLabel.text = "0 to \(Int(sender.value)) real quick"
        drakeView.alpha = CGFloat(sender.value / 100)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        drakeView.alpha = 0
        drakeView.layer.cornerRadius = 3
    }
}
