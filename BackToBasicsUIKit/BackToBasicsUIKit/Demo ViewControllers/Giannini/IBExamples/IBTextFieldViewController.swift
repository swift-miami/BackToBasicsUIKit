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
        guard myTextField.text != nil else {return}
        if myTextField.text!.count > 5 {
            myTextField.text = "\(myTextField.text!.dropLast())"
        }
    }
}
 
 extension IBTextFieldViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard myTextField.text != nil else {return false}
        myTextFieldResultLabel.text = "You typed\n\(myTextField.text!)"
        myTextField.text = ""
        myTextField.resignFirstResponder()
        return true
    }
 }
