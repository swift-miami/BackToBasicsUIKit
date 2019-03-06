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
        let avatarURL: String?
        let location: String?
        var owner: Bool = false

        enum CodingKeys : String, CodingKey {
            case name, location
            case username = "login"
            case avatarURL = "avatar_url"
        }
    }

    // Hard-coded list of usernames and owners from https://github.com/orgs/swift-miami/people
    private let usernames = ["Alejom334", "alfimerino", "chuva-io", "cromanelli", "GianniniCharles", "ivancr", "jslusser", "ryantstone", "paulofierro"]

    // Hard-coded list of owners
    private let owners = ["ivancr", "chuva-io", "ryantstone"]

    // When the data was last updated
    private var updated:Date?

    /// Returns a date formatter to format last updated date
    lazy private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        return formatter
    }()

    /// The title for the VC
    public let title = "Swift Miami Github Members"

    /// The loaded list of users
    public var users = [User]()
}

// MARK: Public Methods for Table View Data

extension PauloViewModel {

    /// The amount of time that has passed since data was loaded
    public var lastUpdated: String {
        guard let date = updated else { return "" }
        return "at \(dateFormatter.string(from: date))"
    }

    /// The number of sections in the table
    public var totalSections: Int {
        return 2
    }

    /// The number of rows in a given section
    public func numberOfRowsInSection(_ section: Int) -> Int {
        return getUsers(isOwner: (section == 0)).count
    }

    /// The title for a given section
    public func titleForSection(_ section: Int) -> String {
        return (section == 0) ? "Owners" : "Members"
    }

    /// Returns the user for a given section/row
    public func userData(for section: Int, row: Int) -> User {
        let users = getUsers(isOwner: (section == 0))
        return users[row]
    }

    /// Returns the list of users that either are or are not owners
    private func getUsers(isOwner: Bool) -> [User] {
        return users.filter { $0.owner == isOwner }
    }
}

// MARK: Networking

extension PauloViewModel {


    /// Loads user data from the Github API
    ///
    /// - Parameters:
    ///   - progress: Returns a float 0...1 indicating the current progress
    ///   - completion: Called when the load operation has completed
    public func loadData(progress: @escaping ((Float) -> Void), completion: @escaping (() -> Void)) {
        var currentIndex = 0
        let totalUsers = usernames.count

        users = []
        usernames.forEach { username in
            loadUser(username) { [weak self] user in
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true

                    // Add the user if we got one
                    if let user = user {
                        self?.users.append(user)
                    }

                    // Update the index
                    currentIndex += 1

                    // Update the progress
                    progress(Float(currentIndex) / Float(totalUsers))

                    // Check if we're done
                    if currentIndex == totalUsers {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = true

                        // Store the last updated date
                        self?.updated = Date()
                        completion()
                    }
                }
            }
        }
    }


    /// Loads a specific user details from the Github API
    ///
    /// - Parameters:
    ///   - username: The user to lookup
    ///   - completionHandler: Returns a User if everything went smoothly
    private func loadUser(_ username: String, completionHandler: @escaping (User?) -> Void) {
        guard let url = URL(string: "https://api.github.com/users/\(username)") else {
            fatalError("Something terrible has happened")
        }

        // Set up the URL session
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let session = URLSession(configuration: configuration)

        let task = session.dataTask(with: url) { (data, response, error) in
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
