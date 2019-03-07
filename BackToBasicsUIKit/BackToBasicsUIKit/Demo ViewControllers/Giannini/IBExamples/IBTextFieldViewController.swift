 /*
 - UITextField
 - How do you customize: text, font, text color (both text and placeholder), background color, border color.
 - How do you conform to its protocol.
  */
 
import UIKit

class IBTextFieldViewController: UIViewController {
    
    @IBOutlet var myTextField: UITextField!
    
    @IBOutlet var myTextFieldResultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTextField.delegate = self
    }
    
    @IBAction func typedInTextField(_ sender: Any) {
        guard let text = myTextField.text, text.count > 5 else { return }
        myTextField.text = "\(text.dropLast())"
    }
}
 
 extension IBTextFieldViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = myTextField.text else {return false}
        myTextFieldResultLabel.text = "You typed\n\(text)"
        myTextField.text = ""
        myTextField.resignFirstResponder()
        return true
    }
 }
