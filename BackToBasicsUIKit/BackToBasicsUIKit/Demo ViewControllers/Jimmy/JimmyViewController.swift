//
//  JimmyViewController.swift
//  BackToBasicsUIKit
//
//  Created by Jimmy Gutierrez on 5/23/19.
//  Copyright © 2019 SwiftMiami. All rights reserved.
//

import UIKit

class JimmyViewController: UIViewController, canRecieve {

    @IBOutlet var label: UILabel!
    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {


    }
    
    
    @IBAction func buttonPressed(_ sender: Any) {
        performSegue(withIdentifier: "sendDataForwards", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendDataForwards" {
            
            let secondVC = segue.destination as! JimmySecondViewController
            
            secondVC.data = textField.text!
            
            secondVC.delegate = self
        }
    }
    
    func dataRecieved(data: String) {
        label.text = data
    }
    
    
}
