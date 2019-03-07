/*
 - UITextField
 - How do you customize: text, font, text color (both text and placeholder), background color, border color.
 - How do you conform to its protocol.
 - UISlider
 - How do you customize it
 - How do you set minimum and maximum values
 - How do you set a value
 */

import UIKit

class GianniniViewController: UIViewController {
    
    override func viewDidLoad() {
        edgesForExtendedLayout = []
        super.viewDidLoad()
    }
    
    @IBAction func didTouchButton(_ sender: UIButton) {
        var gianniniVC = UIViewController()
        switch sender.tag {
        case 1:
            gianniniVC = IBSliderVC()
            gianniniVC.navigationItem.title = "IB Slider"
            
        case 2:
            gianniniVC = ProgrammaticSliderViewController()
            gianniniVC.navigationItem.title = "Programmatic Slider"
            
        case 3:
            gianniniVC = IBTextFieldViewController()
            gianniniVC.navigationItem.title = "IB TextField"
            
        case 4:
            gianniniVC = ProgrammaticTextFieldViewController()
            gianniniVC.navigationItem.title = "Programmatic TextField"
            
        default: break
        }
        navigationController?.pushViewController(gianniniVC, animated: true)
    }
}
