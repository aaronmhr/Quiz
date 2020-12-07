//
//  AppDelegate.swift
//  QuizApp
//
//  Created by Aaron Huánuco on 15/09/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let viewController = QuestionViewController(question: "A question?", options: ["Option 1", "Option 2"], selection: { print($0) })
        _ = viewController.view
        viewController.tableView.allowsMultipleSelection = true
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = viewController
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
}

