//
//  User.swift
//  BackToBasicsUIKit
//
//  Created by Paulo Fierro on 06/03/19.
//  Copyright © 2019 SwiftMiami. All rights reserved.
//

import Foundation

struct User: Codable, Hashable {
    let username: String
    let name: String?
    let avatarURL: String?
    let location: String?
    var owner: Bool = false

    enum CodingKeys: String, CodingKey {
        case name, location
        case username = "login"
        case avatarURL = "avatar_url"
    }
}
