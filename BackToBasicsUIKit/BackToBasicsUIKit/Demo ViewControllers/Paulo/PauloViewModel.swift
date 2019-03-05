//
//  PauloViewModel.swift
//  BackToBasicsUIKit
//
//  Created by Paulo Fierro on 05/03/19.
//  Copyright © 2019 SwiftMiami. All rights reserved.
//

import UIKit

class PauloViewModel {

    struct User: Codable {
        let username: String
        let name: String?
        let avatarURL: String
        let location: String?
        var owner: Bool = false

        enum CodingKeys : String, CodingKey {
            case name, location
            case username = "login"
            case avatarURL = "avatar_url"
        }
    }

    private let usernames = ["Alejom334", "alfimerino", "chuva-io", "cromanelli", "GianniniCharles", "ivancr", "jslusser", "ryantstone"]
    private let owners = ["ivancr", "chuva-io", "ryantstone"]

    public let title = "Paulo's Table View"
    public var lastUpdated: Date?
    public var users = [User]()

    public var totalSections: Int {
        return 2
    }

    public func numberOfRowsInSection(_ section: Int) -> Int {
        if section == 0 {
            let owners = users.filter { $0.owner }
            return owners.count
        }
        else {
            let plebs = users.filter { !$0.owner }
            return plebs.count
        }
    }
}

// MARK: Networking

extension PauloViewModel {

    public func loadData(progress: @escaping ((Float) -> Void), completion: @escaping (() -> Void)) {
        var currentIndex = 0
        let totalUsers = usernames.count

        usernames.forEach { username in
            loadUser(username) { [weak self] user in
                DispatchQueue.main.async {
                    if let user = user {
                        self?.users.append(user)
                    }
                    currentIndex += 1

                    // Update the progress
                    progress(Float(currentIndex) / Float(totalUsers))

                    if currentIndex == totalUsers {
                        self?.lastUpdated = Date()
                        completion()
                    }
                }
            }
        }
    }

    private func loadUser(_ username: String, completionHandler: @escaping (User?) -> Void) {
        guard let url = URL(string: "https://api.github.com/users/\(username)") else {
            fatalError("Something terrible has happened")
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Could not load user \(username)")
                completionHandler(nil)
                return
            }
            do {
                var user = try JSONDecoder().decode(User.self, from: data)
                if self.owners.contains(user.username) {
                    user.owner = true
                }
                completionHandler(user)
            }
            catch {
                print("Could not decode user \(error)")
            }
        }
        task.resume()
    }
}
