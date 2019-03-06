/*
 - UIProgressView
    - How do you customize it
    - How do you set animated progress
 - UIPickerView
    - How do you conform to the delegate and dataSource protocols
    - How do you use it
 */

import UIKit

class JimViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var favoriteMonthTextField: UITextField!
    
    let progress = Progress(totalUnitCount: 10)
    
    let months = ["January",
                  "February",
                  "March",
                  "April",
                  "May",
                  "June",
                  "July",
                  "August",
                  "September",
                  "October",
                  "November",
                  "December"]
    
    var selectedMonth: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMonthPicker()
        createToolbar()
        
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 5)
    }
    
    @IBAction func didTapStartProgress(_ sender: Any) {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            
            guard self.progress.isFinished == false else {
                timer.invalidate()
                print("finished")
                
                return
            }
            
            self.progress.completedUnitCount += 1
            
            let progressFloat = Float(self.progress.fractionCompleted)
            self.progressView.setProgress(progressFloat, animated: true)
        }
    }
    
    func createMonthPicker() {
        
        let monthPicker = UIPickerView()
        monthPicker.delegate = self as! UIPickerViewDelegate
        
        favoriteMonthTextField.inputView = monthPicker
        
        //Customizations
        // monthPicker.backgroundColor = .black
    }
    
    
    func createToolbar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        // Customizations
        //    toolBar.barTintColor = .black
        //    toolBar.tintColor = .white
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(JimViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        favoriteMonthTextField.inputAccessoryView = toolBar
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension JimViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return months.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return months[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedMonth = months[row]
        favoriteMonthTextField.text = selectedMonth
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        
        //    label.textColor = .yellow
        label.textAlignment = .center
        //    label.font = UIFont(name: "Menlo-Regular", size: 17)
        
        label.text = months[row]
        
        return label
    }
}

