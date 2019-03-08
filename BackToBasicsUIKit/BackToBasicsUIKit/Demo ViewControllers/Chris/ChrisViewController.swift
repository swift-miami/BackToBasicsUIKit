/*
 - UIButton
    - How do you customize: text, font, text color, background color, attributed text and corner radius.
    - How do you add an action/target.
 - UIBarButtonItem
    - How do you customize: text, font, text color
    - How do you add it to a NavigationBar
 */

import UIKit

class ChrisViewController: UIViewController {
    
    @IBOutlet weak var storyboardButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        createButton()
        createBarButton()
    }
    
    //IBActions
    @IBAction func storyboardButtonPressed(_ sender: UIButton) {
        showAlert(sender: sender)
    }
    
}

extension ChrisViewController {
    
    func createBarButton() {
        let barButton = UIBarButtonItem(title: "⭐️", style: UIBarButtonItem.Style.plain, target: self, action: #selector(showBarAlert))
        let barButton2 = UIBarButtonItem(title: "👋", style: UIBarButtonItem.Style.plain, target: self, action: #selector(exit))
        let barButton3 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(createAnotherButton))
        let barButton4 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: nil)
        
        //You can add UIBarButtonItems to the left & right part of the UINavigationItem.
        //by setting leftBarButtonItem or rightBarButtonItem UINavigationItem properties
        self.navigationItem.rightBarButtonItems = [barButton4,barButton3, barButton]
        self.navigationItem.leftBarButtonItems = [barButton2]
    }
    
    func createButton() {
        let myButton = UIButton(frame: CGRect.zero) //Instanciate an UIButton with a Zero Frame

        // addTarget method is the way you can programmatically add an action to a button
        myButton.addTarget(self, action: #selector(showAlert(sender:)), for: .touchUpInside)
        
        //You can also change the font sby asigning a custom font to the button's titleLabel.
        let font = UIFont(name: "Courier", size: 18.0)
        myButton.titleLabel?.font = font
        
        //To change a UIButton Title use the setTitle method, you can assign a title for each of the button state
        myButton.setTitle("Press Me 😀", for: .normal)
        myButton.setTitle("Ouch! 😣", for: .highlighted)
        
        //To change a UIButton Background color just assign an UIColor to the backgroundColor property of the UIButton.
        myButton.backgroundColor = UIColor(red: 72.0/255.0, green: 207.0/255.0, blue: 129.0/255.0, alpha: 1.0)
        
        //UIButton Inherits from UIView -> UIControl -> UIButton therefore
        //1.- Change UIButton Corner:
        myButton.layer.cornerRadius = 5.0
        
        //2.- Change Border Color and Width
        myButton.layer.borderColor = UIColor.white.cgColor
        myButton.layer.borderWidth = 1.0
        
        //3.- Drop a Shadow
        myButton.layer.shadowColor = UIColor.black.cgColor
        myButton.layer.shadowOpacity = 0.4
        myButton.layer.shadowRadius  = 4.0
        myButton.layer.shadowOffset  = CGSize(width: 2.0, height: 2.0)
        
        view.addSubview(myButton) // <--- Add it to the view
        
        // You can also create Contraints for the UIButton 👇
        myButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: myButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 170).isActive = true
        NSLayoutConstraint(item: myButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 44).isActive = true
        NSLayoutConstraint(item: myButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: myButton, attribute: NSLayoutConstraint.Attribute.top, relatedBy: .equal, toItem: storyboardButton, attribute: .bottom, multiplier: 1, constant: 50).isActive = true
    }
    
    @objc func createAnotherButton() {
        
        // You can also create a button and assing a type right away using the convenience init
        let anotherButton = UIButton(type: .custom)
        anotherButton.layer.borderColor = UIColor.blue.cgColor
        anotherButton.layer.borderWidth = 1.0
        anotherButton.layer.cornerRadius = 5.0
        anotherButton.setTitle("New Button", for: .normal)
        anotherButton.setTitleColor(.blue, for: .normal)
        
        //To add an Image to the button use setImage function
        let swiftMiamiLogo = UIImage(named: "SwiftMiamiLogo")
        anotherButton.setImage(swiftMiamiLogo, for: .normal)
        
        //Button's font can be changed
        let font = UIFont(name: "AmericanTypewriter", size: UIFont.systemFontSize)
        anotherButton.titleLabel?.font = font
        
        //To adjust the position of the Image and Title you assign imageEdgeInsets & titleEdgeInsets vars.
        anotherButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 140)
        anotherButton.titleEdgeInsets = UIEdgeInsets(top: 10, left: -970, bottom: 10, right: 10)
        
        //Finally to manage content alignment you set contentHorizontalAlignment & contentVerticalAlignment vars
        anotherButton.contentHorizontalAlignment = .left
        anotherButton.contentVerticalAlignment = .center
        
        view.addSubview(anotherButton)
        
        // Contraints
        anotherButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: anotherButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 170).isActive = true
        NSLayoutConstraint(item: anotherButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 44).isActive = true
        NSLayoutConstraint(item: anotherButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: anotherButton, attribute: NSLayoutConstraint.Attribute.top, relatedBy: .equal, toItem: storyboardButton, attribute: .bottom, multiplier: 1, constant: 250).isActive = true
    }
    
    // AlertViewControllers & Exit Functions
    @objc func showBarAlert() {
        let alert = UIAlertController(title: "Hey,", message: "UIBarButtonItem ⭐️ Clicked", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func exit() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func showAlert(sender: UIButton) {
        let text = sender.currentTitle! // 👈 You can read an UIButton Title by using this property.
        let alert = UIAlertController(title: "Button Pressed", message: "\(text) pressed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
