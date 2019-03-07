//
//  SpinnerVC.swift
//  BackToBasicsUIKit
//
//  Created by Nilson Nascimento on 3/7/19.
//  Copyright © 2019 SwiftMiami. All rights reserved.
//

import UIKit

class SpinnerVC: UIViewController {

    @IBOutlet var spinnerView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        spinnerView.startAnimating()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        spinnerView.startAnimating()
    }

    @objc func barButtonTapped() {

    }

}
