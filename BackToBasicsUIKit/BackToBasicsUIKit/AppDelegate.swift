//
//  AppDelegate.swift
//  BackToBasicsUIKit
//
//  Created by Ivan Ruiz on 2/12/19.
//  Copyright © 2019 SwiftMiami. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: MainTableViewController())
        window?.makeKeyAndVisible()

        return true
    }
}
