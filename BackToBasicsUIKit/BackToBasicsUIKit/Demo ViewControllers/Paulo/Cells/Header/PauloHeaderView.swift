//
//  PauloHeaderView.swift
//  BackToBasicsUIKit
//
//  Created by Paulo Fierro on 06/03/19.
//  Copyright © 2019 SwiftMiami. All rights reserved.
//

import UIKit

class PauloHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak private var label: UILabel!
    @IBOutlet weak private var backgroundImageView: UIImageView!

    public static let identifier = "pauloHeaderViewIdentifier"
    public static let height: CGFloat = 50

    // Draw a gradient background
    lazy private var backgroundGradient: UIImage? = {
        guard let topColor = UIColor(named: "purple"),
            let bottomColor = UIColor(named: "blue")?.withAlphaComponent(0.5)
            else { return nil}

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.bounds = bounds
        UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, false, 0.0)

        defer {
            UIGraphicsEndImageContext()
        }

        guard let context = UIGraphicsGetCurrentContext() else { return nil}
        gradientLayer.render(in: context)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundImageView.image = backgroundGradient
    }

    public func setTitle(_ title: String) {
        label.text = title
    }
}
