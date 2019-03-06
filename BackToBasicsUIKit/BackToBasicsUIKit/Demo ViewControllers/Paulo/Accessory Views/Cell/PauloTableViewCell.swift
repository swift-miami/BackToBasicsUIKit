//
//  PauloTableViewCell.swift
//  BackToBasicsUIKit
//
//  Created by Paulo Fierro on 06/03/19.
//  Copyright © 2019 SwiftMiami. All rights reserved.
//

import UIKit

class PauloTableViewCell: UITableViewCell {

    @IBOutlet weak private var avatarImageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var locationLabel: UILabel!
    @IBOutlet weak private var locationFlag: UILabel!
    @IBOutlet weak private var flagStackView: UIStackView!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!

    // In the real world we could use R.swift to get this from the NIB automatically
    public static let identifier = "pauloTableViewCell"

    // Setup the view once the NIB has been loaded
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = abs(avatarImageView.frame.width/2) as CGFloat
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    /// Render the user data
    public func setData(name: String?, imageURL: String?, location: String?) {
        nameLabel.text = name
        loadImage(imageURL: imageURL)

        // Update the location
        locationLabel.text = location
        // Show or hide the bottom stack depending on if we have a location
        if location != nil {
            flagStackView.isHidden = false
            // Super hacky way of showing a different flag for me
            locationFlag.text = (location == "Cayman Islands") ? "🇰🇾" : "🇺🇸"
        }
        else {
            flagStackView.isHidden = true
        }
    }

    /// Load the user's avatar and display it
    private func loadImage(imageURL: String?) {
        guard let imageURL = imageURL,
            let url = URL(string: imageURL) else { return }

        activityIndicator.startAnimating()

        // ⚠️ THIS IS AWFUL!!!
        // This should never be shipped in a real app. Use
        // a third-party library like Kingfisher, SDWebImage
        // or similar, or roll your own code that downloads the
        // image properly, in an asynchronous manner and caches it.
        DispatchQueue.global(qos: .userInitiated).async {
            guard let imageData = try? Data(contentsOf: url),
                let image = UIImage(data: imageData) else { return }

            DispatchQueue.main.async { [weak self] in
                self?.avatarImageView.image = image
                self?.activityIndicator.stopAnimating()
            }
        }
    }
}
