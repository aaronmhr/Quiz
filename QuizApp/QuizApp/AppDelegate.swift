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
        let viewController = ResultsViewController(summary: "You got 1/2 correct", answers: [
            PresentableAnswer(question: "Question", answer: "Answer", wrongAnswer: nil),
            PresentableAnswer(question: "Question", answer: "Hell yeah!", wrongAnswer: "Hell no!")
        ])

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = viewController
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
}

