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

let question1 = Question.singleAnswer("What's Mike's nationality?")
let question2 = Question.multipleAnswer("What's Caio's nationalities?")

let questions = [question1, question2]

let option1 = "Canadian"
let option2 = "American"
let option3 = "Greek"
let options1 = [option1, option2, option3]

let option4 = "Portuguese"
let option5 = "American"
let option6 = "Brazilian"
let options2 = [option4, option5, option6]

let options = [question1: options1, question2: options2]
let correctAnswers = [(question1, [option3]), (question2, [option4, option6])]
