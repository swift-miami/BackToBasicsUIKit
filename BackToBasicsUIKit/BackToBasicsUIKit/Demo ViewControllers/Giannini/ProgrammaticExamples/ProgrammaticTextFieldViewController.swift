 /*
  - UITextField
  - How do you customize: text, font, text color (both text and placeholder), background color, border color.
  - How do you conform to its protocol.
  */

import UIKit

class ProgrammaticTextFieldViewController: UIViewController, UITextFieldDelegate {
    
        let proTextField = UITextField()
        
        var proTextFieldResultLabel = UILabel()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .yellow
            setupProTextField()
            layoutConstraints()
        }
    
    func setupProTextField() {
        view.addSubview(proTextField)
        proTextField.delegate = self
        proTextField.addTarget(self, action: #selector(self.textFieldDidEndEditing(_:)), for: UIControl.Event.editingDidEnd)
        proTextField.placeholder = "Type a message..."
        proTextField.backgroundColor = .orange
        proTextField.textColor = .purple
        proTextField.layer.borderWidth = 3
        proTextField.layer.borderColor = UIColor.purple.cgColor
        proTextField.font = UIFont (name: "Menlo-Bold", size: 20)
        proTextField.textAlignment = .center
        guard  proTextField.placeholder != nil else { return }
        proTextField.attributedPlaceholder = NSAttributedString(string: proTextField.placeholder!,
                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue])
    }

    func layoutConstraints() {
        proTextField.translatesAutoresizingMaskIntoConstraints = false
        proTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        proTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        proTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        proTextField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        proTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        guard proTextField.text != nil else {return}
        let alert = UIAlertController(title: "TextField Text:", message: proTextField.text!, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        self.present(alert, animated: true) {
            self.proTextField.text = ""
            }
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard proTextField.text != nil else {return false}
        proTextField.resignFirstResponder()
        return true
        }
    }
 

 
    




