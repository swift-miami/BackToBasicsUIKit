/*
 Things to Demo
 - UITextView
    - How do you customize: text, font, text color,
    - How do you support tapable links (urls, phone numbers, etc)
    - How do you conform to its protocol.
 - UIStepper
    - How do you customize it.
    - How do you add an action/target.
    - How do you set a min and max value
    - How do you set the step amount? Increment by 1, 5 or 10, for example.
 */

import UIKit

class FreddyViewController: UIViewController {
    @IBOutlet weak var textView1: UITextView!
    
    @IBOutlet weak var textView2: UITextView!
   
    @IBOutlet weak var textView3: UITextView!
    
    @IBOutlet weak var textView4: UITextView!
    
    // Stepper 1:
    @IBOutlet weak var stTextView1: UITextView!
    @IBOutlet weak var lable1: UILabel!
    
    @IBOutlet weak var stepper1: UIStepper!
    
    
    // Stepper 2:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // textView 1
        textView1.text = "Text View 1: This view will show a standard green background color and purple text color... BORING!!!"
        textView1.backgroundColor = UIColor.green
        textView1.textColor = UIColor.purple
        
        // textView 2
        textView2.text = "Text View 2: This view will show a custom purple backgound and orange text color (RGB values). Font Size: 20 Font Type: Times New Roman"
        textView2.backgroundColor = UIColor(displayP3Red: 52/255, green: 0/255, blue: 102/255, alpha: 1)
        textView2.textColor = UIColor(displayP3Red: 210/255, green: 80/255, blue: 40/255, alpha: 1)
        textView2.font = UIFont(name: "Times", size: 20)

        // textView 3
        textView3.text = "Text View 3: This view will not allow the user to edit this textview. Also, here's a link to tap on! www.github.com/swift-miami"
        textView3.isEditable = false
        textView3.isSelectable = true
        textView3.dataDetectorTypes = UIDataDetectorTypes.link
        
        // textView 4
        textView4.text = "Text View 4: This is a text view that handles phone numbers. Text Jenny for a good time.. (305)867-5309"
        textView4.backgroundColor = UIColor.red
        textView4.isSelectable = true
        textView4.isEditable = false
        textView4.dataDetectorTypes = UIDataDetectorTypes.phoneNumber
        
        // Stepper 1: Customization
        stTextView1.text = "In steps of 5. Max Val: 20, Min Val: -5"
        stepper1.maximumValue = 20
        stepper1.minimumValue = -5
        lable1.text = "\(self.stepper1.value)" //Displays the starting value of stepper.
    }
    // Stepper 1 Action
    @IBAction func stepperTapped1(_ sender: UIStepper) {
        // Displays value of stepper in label
        self.lable1.text = "\(self.stepper1.value)"
        
    }
}
