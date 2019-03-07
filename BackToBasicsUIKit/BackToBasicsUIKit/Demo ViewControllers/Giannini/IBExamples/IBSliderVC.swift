/*
 - UISlider
 - How do you customize it
 - How do you set minimum and maximum values
 - How do you set a value
 */

import UIKit

class IBSliderVC: UIViewController {
    
    @IBOutlet var drakeImageView: UIImageView!
    
    @IBOutlet var lbl0To100: UILabel!
    
    @IBAction func didMoveSlider(_ sender: UISlider) {
        lbl0To100.text = "0 to \(Int(sender.value)) real quick"
        drakeImageView.alpha = CGFloat(sender.value / 100)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        drakeImageView.alpha = 0
        drakeImageView.layer.cornerRadius = 3
    }
}
