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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
