//
//  User.swift
//  BackToBasicsUIKit
//
//  Created by Paulo Fierro on 06/03/19.
//  Copyright © 2019 SwiftMiami. All rights reserved.
//

import UIKit

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

    init(username: String, avatarURL: String?) {
        self.username = username
        self.name = nil
        self.avatarURL = avatarURL
        self.location = nil
    }
}

extension User {

    /// Check if we can handle drops of this type of item
    public static func canHandle(_ session: UIDropSession) -> Bool {
        let canLoad = session.canLoadObjects(ofClass: NSString.self)
        return canLoad
    }
}
