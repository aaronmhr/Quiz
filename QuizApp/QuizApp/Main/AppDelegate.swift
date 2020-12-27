//
//  AppDelegate.swift
//  QuizApp
//
//  Created by Aaron Huánuco on 15/09/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import UIKit
import SwiftUI
import QuizEngine

class AppStore {
    var quiz: Quiz?
}

@main
struct QuizApp: App {
    let appStore = AppStore()
    @StateObject var navigationStore = QuizNavigationStore()

    var body: some Scene {
        WindowGroup {
            QuizNavigationView(store: navigationStore)
                .onAppear(perform: startNewQuiz)
        }
    }

    private func startNewQuiz() {
        let adapter = iOSSwiftUINavigationAdapter(
            navigation: navigationStore,
            options: options,
            correctAnswers: correctAnswers,
            playAgain: startNewQuiz
        )

        appStore.quiz = Quiz.start(questions: questions, delegate: adapter)
    }
}

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var quiz: Quiz?

    private lazy var navigationController = UINavigationController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        startNewQuiz()
        return true
    }

    private func startNewQuiz() {
        let factory = iOSUIKitViewControllerFactory(
            options: options,
            correctAnswers: correctAnswers)
        let router = NavigationControllerRouter(navigationController, factory: factory)

        quiz = Quiz.start(questions: questions, delegate: router)
    }
}
