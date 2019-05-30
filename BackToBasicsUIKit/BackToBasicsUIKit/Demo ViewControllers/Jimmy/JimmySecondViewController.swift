//
//  JimmySecondViewController.swift
//  BackToBasicsUIKit
//
//  Created by Jimmy Gutierrez on 5/23/19.
//  Copyright © 2019 SwiftMiami. All rights reserved.
//

import UIKit

protocol canRecieve {
    func dataRecieved(data: String)
}

class JimmySecondViewController: UIViewController {
    
    var delegate : canRecieve?
    
    var data = ""
    
    @IBOutlet var label: UILabel!
    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = data

    }
    
    
    @IBAction func passItBack(_ sender: Any) {
       delegate?.dataRecieved(data: textField.text!)
        self.navigationController?.popViewController(animated: true)
//        dismiss(animated: true, completion: nil)
        
    }
    

    
}

