//
//  QuizApp.swift
//  QuizApp
//
//  Created by Aaron Huánuco on 27/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

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
            options: demoQuiz.options,
            correctAnswers: demoQuiz.correctAnswers,
            playAgain: startNewQuiz
        )

        appStore.quiz = Quiz.start(questions: demoQuiz.questions, delegate: adapter)
    }
}
