//
//  iOSSwiftUINavigationAdapter.swift
//  QuizApp
//
//  Created by Aaron Huánuco on 25/12/20.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import UIKit
import SwiftUI
import QuizEngine

final class iOSSwiftUINavigationAdapter: QuizDelegate {
    typealias Question = QuizEngine.Question<String>
    typealias Answer = [String]
    typealias Answers = [(question: Question, answer: Answer)]

    private let navigation: UINavigationController
    private let options: [Question: Answer]
    private let correctAnswers: Answers
    private let playAgain: () -> Void

    private var questions: [Question] {
        correctAnswers.map(\.question)
    }

    init(navigation: UINavigationController, options: [Question: Answer], correctAnswers: Answers, playAgain: @escaping () -> Void) {
        self.navigation = navigation
        self.options = options
        self.correctAnswers = correctAnswers
        self.playAgain = playAgain
    }

    func answer(for question: Question, completion: @escaping (Answer) -> Void) {
        showController(questionViewController(for: question, answerCallback: completion))
    }

    func didCompleteQuiz(withAnswers answers: Answers) {
        showController(resultsViewController(for: answers))
    }

    private func showController(_ controller: UIViewController) {
        navigation.setViewControllers([controller], animated: true)
    }

    private func questionViewController(for question: Question, answerCallback: @escaping (Answer) -> Void) -> UIViewController {
        guard let options = self.options[question] else {
            fatalError("Couldn't find options for question: \(question)")
        }

        return questionViewController(for: question, options: options, answerCallback: answerCallback)
    }

    private func questionViewController(for question: Question, options: Answer, answerCallback: @escaping (Answer) -> Void) -> UIViewController {
        let presenter = QuestionPresenter(questions: questions, question: question)

        switch question {
        case .singleAnswer(let value):
            return UIHostingController(
                rootView: SingleAnswerQuestion(
                    title: presenter.title,
                    question: value,
                    options: options,
                    selection: { answerCallback([$0]) }))

        case .multipleAnswer(let value):
            return UIHostingController(
                rootView: MultipleAnswerQuestion(
                    title: presenter.title,
                    question: value,
                    store: .init(options: options, handler: answerCallback)
                )
            )
        }
    }

    private func questionViewController(for question: Question, value: String, options: Answer, allowsMultipleSelection: Bool, answerCallback: @escaping (Answer) -> Void) -> QuestionViewController {
        let presenter = QuestionPresenter(questions: questions, question: question)
        let controller = QuestionViewController(question: value, options: options, allowsMultipleSelection: allowsMultipleSelection, selection: answerCallback)
        controller.title = presenter.title
        return controller
    }

    private func resultsViewController(for userAnswers: Answers) -> UIViewController {
        let presenter = ResultsPresenter(
            userAnswers: userAnswers,
            correctAnswers: correctAnswers,
            scorer: BasicScore.score)

        return UIHostingController(
            rootView: ResultView(
                title: presenter.title,
                summary: presenter.summary,
                answers: presenter.presentableAnswers,
                playAgain: playAgain))
    }
}
